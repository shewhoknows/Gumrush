-- Friend codes, friend requests, and code-based live duel invites.
-- This migration backs the Swift friend-code/live-room repositories.

create extension if not exists "pgcrypto";

alter table public.profiles
add column if not exists friend_code text;

create unique index if not exists idx_profiles_friend_code_unique
on public.profiles(upper(friend_code))
where friend_code is not null;

create table if not exists public.friendships (
  id uuid primary key default gen_random_uuid(),
  requester_id uuid not null references public.profiles(id) on delete cascade,
  addressee_id uuid not null references public.profiles(id) on delete cascade,
  status text not null default 'pending'
    check (status in ('pending', 'accepted', 'declined', 'cancelled')),
  created_at timestamptz not null default now(),
  responded_at timestamptz,
  check (requester_id <> addressee_id)
);

create unique index if not exists idx_friendships_pair_unique
on public.friendships(
  least(requester_id, addressee_id),
  greatest(requester_id, addressee_id)
);

create index if not exists idx_friendships_requester_status
on public.friendships(requester_id, status, created_at desc);

create index if not exists idx_friendships_addressee_status
on public.friendships(addressee_id, status, created_at desc);

create table if not exists public.live_duel_invites (
  id uuid primary key default gen_random_uuid(),
  match_id uuid not null references public.matches(id) on delete cascade,
  host_id uuid not null references public.profiles(id) on delete cascade,
  guest_id uuid references public.profiles(id) on delete set null,
  join_code text not null,
  topic_id uuid not null references public.topics(id),
  status text not null default 'pending'
    check (status in ('pending', 'accepted', 'cancelled', 'expired')),
  expires_at timestamptz not null default (now() + interval '10 minutes'),
  created_at timestamptz not null default now(),
  accepted_at timestamptz
);

create unique index if not exists idx_live_duel_invites_join_code_unique
on public.live_duel_invites(upper(join_code));

create index if not exists idx_live_duel_invites_host_status
on public.live_duel_invites(host_id, status, created_at desc);

create index if not exists idx_live_duel_invites_guest_status
on public.live_duel_invites(guest_id, status, created_at desc);

alter table public.friendships enable row level security;
alter table public.live_duel_invites enable row level security;

drop policy if exists "friendships_read_involved" on public.friendships;
create policy "friendships_read_involved"
on public.friendships for select
to authenticated
using (requester_id = auth.uid() or addressee_id = auth.uid());

drop policy if exists "friendships_insert_requester" on public.friendships;
create policy "friendships_insert_requester"
on public.friendships for insert
to authenticated
with check (requester_id = auth.uid());

drop policy if exists "friendships_update_involved" on public.friendships;
create policy "friendships_update_involved"
on public.friendships for update
to authenticated
using (requester_id = auth.uid() or addressee_id = auth.uid())
with check (requester_id = auth.uid() or addressee_id = auth.uid());

drop policy if exists "live_duel_invites_read_involved_or_joinable" on public.live_duel_invites;
create policy "live_duel_invites_read_involved_or_joinable"
on public.live_duel_invites for select
to authenticated
using (
  host_id = auth.uid()
  or guest_id = auth.uid()
  or (status = 'pending' and expires_at > now())
);

drop policy if exists "live_duel_invites_insert_host" on public.live_duel_invites;
create policy "live_duel_invites_insert_host"
on public.live_duel_invites for insert
to authenticated
with check (host_id = auth.uid());

drop policy if exists "live_duel_invites_update_involved" on public.live_duel_invites;
create policy "live_duel_invites_update_involved"
on public.live_duel_invites for update
to authenticated
using (host_id = auth.uid() or guest_id = auth.uid())
with check (host_id = auth.uid() or guest_id = auth.uid());

create or replace function public.random_join_code(code_length integer default 6)
returns text
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  alphabet constant text := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  output text := '';
  idx integer;
begin
  if code_length < 4 or code_length > 16 then
    raise exception 'code_length must be between 4 and 16';
  end if;

  for idx in 1..code_length loop
    output := output || substr(alphabet, floor(random() * length(alphabet) + 1)::integer, 1);
  end loop;

  return output;
end;
$$;

revoke all on function public.random_join_code(integer) from public;

create or replace function public.ensure_friend_code()
returns text
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  generated_code text;
  existing_code text;
  attempts integer := 0;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  select p.friend_code
  into existing_code
  from public.profiles p
  where p.id = auth.uid();

  if existing_code is not null and length(existing_code) > 0 then
    return existing_code;
  end if;

  loop
    attempts := attempts + 1;
    generated_code := public.random_join_code(6);

    begin
      update public.profiles
      set friend_code = generated_code,
          updated_at = now()
      where id = auth.uid();

      if found then
        return generated_code;
      end if;

      raise exception 'Profile not found for current user';
    exception
      when unique_violation then
        if attempts >= 20 then
          raise exception 'Could not generate a unique friend code';
        end if;
    end;
  end loop;
end;
$$;

revoke all on function public.ensure_friend_code() from public;
grant execute on function public.ensure_friend_code() to authenticated;

create or replace function public.lookup_profile_by_friend_code(p_friend_code text)
returns table (
  id uuid,
  username text,
  display_name text,
  avatar_seed text
)
language sql
stable
security definer
set search_path = public
as $$
  select p.id, p.username, p.display_name, p.avatar_seed
  from public.profiles p
  where upper(p.friend_code) = upper(regexp_replace(coalesce(p_friend_code, ''), '[^A-Za-z0-9]', '', 'g'))
  limit 1;
$$;

revoke all on function public.lookup_profile_by_friend_code(text) from public;
grant execute on function public.lookup_profile_by_friend_code(text) to authenticated;

create or replace function public.send_friend_request(p_friend_code text)
returns text
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  target_id uuid;
  existing_id uuid;
  normalized_code text;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  normalized_code := upper(regexp_replace(coalesce(p_friend_code, ''), '[^A-Za-z0-9]', '', 'g'));

  select p.id
  into target_id
  from public.profiles p
  where upper(p.friend_code) = normalized_code
  limit 1;

  if target_id is null then
    raise exception 'No player found with that friend code';
  end if;

  if target_id = auth.uid() then
    raise exception 'You cannot add yourself as a friend';
  end if;

  select f.id
  into existing_id
  from public.friendships f
  where (f.requester_id = auth.uid() and f.addressee_id = target_id)
     or (f.requester_id = target_id and f.addressee_id = auth.uid())
  limit 1;

  if existing_id is not null then
    update public.friendships
    set status = case when status in ('declined', 'cancelled') then 'pending' else status end,
        requester_id = case when status in ('declined', 'cancelled') then auth.uid() else requester_id end,
        addressee_id = case when status in ('declined', 'cancelled') then target_id else addressee_id end,
        responded_at = case when status in ('declined', 'cancelled') then null else responded_at end
    where id = existing_id;

    return existing_id::text;
  end if;

  insert into public.friendships(requester_id, addressee_id, status)
  values (auth.uid(), target_id, 'pending')
  returning id into existing_id;

  return existing_id::text;
end;
$$;

revoke all on function public.send_friend_request(text) from public;
grant execute on function public.send_friend_request(text) to authenticated;

create or replace function public.accept_friend_request(p_friendship_id uuid)
returns text
language plpgsql
volatile
security definer
set search_path = public
as $$
begin
  update public.friendships
  set status = 'accepted',
      responded_at = now()
  where id = p_friendship_id
    and addressee_id = auth.uid()
    and status = 'pending';

  if not found then
    raise exception 'Friend request not found';
  end if;

  return p_friendship_id::text;
end;
$$;

revoke all on function public.accept_friend_request(uuid) from public;
grant execute on function public.accept_friend_request(uuid) to authenticated;

create or replace function public.decline_friend_request(p_friendship_id uuid)
returns text
language plpgsql
volatile
security definer
set search_path = public
as $$
begin
  update public.friendships
  set status = 'declined',
      responded_at = now()
  where id = p_friendship_id
    and addressee_id = auth.uid()
    and status = 'pending';

  if not found then
    raise exception 'Friend request not found';
  end if;

  return p_friendship_id::text;
end;
$$;

revoke all on function public.decline_friend_request(uuid) from public;
grant execute on function public.decline_friend_request(uuid) to authenticated;

create or replace function public.cancel_friend_request(p_friendship_id uuid)
returns text
language plpgsql
volatile
security definer
set search_path = public
as $$
begin
  update public.friendships
  set status = 'cancelled',
      responded_at = now()
  where id = p_friendship_id
    and requester_id = auth.uid()
    and status = 'pending';

  if not found then
    raise exception 'Friend request not found';
  end if;

  return p_friendship_id::text;
end;
$$;

revoke all on function public.cancel_friend_request(uuid) from public;
grant execute on function public.cancel_friend_request(uuid) to authenticated;

create or replace function public.create_live_duel_invite(p_topic_id uuid)
returns table (
  invite_id uuid,
  match_id uuid,
  join_code text,
  topic_id uuid,
  expires_at timestamptz
)
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  new_match_id uuid;
  new_invite_id uuid;
  generated_code text;
  attempts integer := 0;
  question_count integer;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  if not exists (
    select 1 from public.topics t
    where t.id = p_topic_id and t.status = 'active'
  ) then
    raise exception 'Topic not found';
  end if;

  select count(*)
  into question_count
  from public.questions q
  where q.topic_id = p_topic_id
    and q.status = 'approved';

  if question_count < 7 then
    raise exception 'Not enough approved questions for this topic';
  end if;

  insert into public.matches(topic_id, match_type, status, created_by)
  values (p_topic_id, 'live', 'waiting', auth.uid())
  returning id into new_match_id;

  insert into public.match_players(match_id, user_id, player_slot)
  values (new_match_id, auth.uid(), 1);

  insert into public.match_questions(match_id, question_id, question_index)
  select new_match_id, picked.id, row_number() over () - 1
  from (
    select q.id
    from public.questions q
    where q.topic_id = p_topic_id
      and q.status = 'approved'
    order by random()
    limit 7
  ) picked;

  loop
    attempts := attempts + 1;
    generated_code := public.random_join_code(6);

    begin
      insert into public.live_duel_invites(match_id, host_id, join_code, topic_id)
      values (new_match_id, auth.uid(), generated_code, p_topic_id)
      returning id into new_invite_id;

      exit;
    exception
      when unique_violation then
        if attempts >= 20 then
          raise exception 'Could not generate a unique live room code';
        end if;
    end;
  end loop;

  return query
  select i.id, i.match_id, i.join_code, i.topic_id, i.expires_at
  from public.live_duel_invites i
  where i.id = new_invite_id;
end;
$$;

revoke all on function public.create_live_duel_invite(uuid) from public;
grant execute on function public.create_live_duel_invite(uuid) to authenticated;

create or replace function public.join_live_duel_invite(p_join_code text)
returns table (
  invite_id uuid,
  match_id uuid,
  host_id uuid,
  topic_id uuid
)
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  target_invite public.live_duel_invites%rowtype;
  normalized_code text;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  normalized_code := upper(regexp_replace(coalesce(p_join_code, ''), '[^A-Za-z0-9]', '', 'g'));

  select *
  into target_invite
  from public.live_duel_invites i
  where upper(i.join_code) = normalized_code
    and i.status = 'pending'
    and i.expires_at > now()
  order by i.created_at desc
  limit 1
  for update;

  if target_invite.id is null then
    raise exception 'Live room not found or expired';
  end if;

  if target_invite.host_id = auth.uid() then
    raise exception 'You cannot join your own live room';
  end if;

  insert into public.match_players(match_id, user_id, player_slot)
  values (target_invite.match_id, auth.uid(), 2)
  on conflict (match_id, user_id) do nothing;

  update public.live_duel_invites
  set guest_id = auth.uid(),
      status = 'accepted',
      accepted_at = now()
  where id = target_invite.id;

  update public.matches
  set status = 'in_progress',
      started_at = coalesce(started_at, now())
  where id = target_invite.match_id
    and status = 'waiting';

  return query
  select i.id, i.match_id, i.host_id, i.topic_id
  from public.live_duel_invites i
  where i.id = target_invite.id;
end;
$$;

revoke all on function public.join_live_duel_invite(text) from public;
grant execute on function public.join_live_duel_invite(text) to authenticated;
