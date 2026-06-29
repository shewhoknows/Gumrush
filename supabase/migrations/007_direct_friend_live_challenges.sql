-- Direct friend live challenges and live-room join ambiguity fix.
-- Migration 006 is already deployed; replace RPC bodies here instead.

create or replace function public.create_live_duel_invite(p_topic_id uuid, p_guest_id uuid)
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
#variable_conflict use_column
declare
  v_match_id uuid;
  v_invite_id uuid;
  v_join_code text;
  v_attempts integer := 0;
  v_question_count integer;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  if p_guest_id = auth.uid() then
    raise exception 'You cannot challenge yourself';
  end if;

  if not exists (
    select 1
    from public.topics t
    where t.id = p_topic_id
      and t.status = 'active'
  ) then
    raise exception 'Topic not found';
  end if;

  if p_guest_id is not null and not exists (
    select 1
    from public.friendships f
    where f.status = 'accepted'
      and (
        (f.requester_id = auth.uid() and f.addressee_id = p_guest_id)
        or (f.requester_id = p_guest_id and f.addressee_id = auth.uid())
      )
  ) then
    raise exception 'You can only challenge an accepted friend';
  end if;

  select count(*)
  into v_question_count
  from public.questions q
  where q.topic_id = p_topic_id
    and q.status = 'approved';

  if v_question_count < 7 then
    raise exception 'Not enough approved questions for this topic';
  end if;

  insert into public.matches(topic_id, match_type, status, created_by)
  values (p_topic_id, 'live', 'waiting', auth.uid())
  returning id into v_match_id;

  insert into public.match_players(match_id, user_id, player_slot)
  values (v_match_id, auth.uid(), 1);

  insert into public.match_questions(match_id, question_id, question_index)
  select v_match_id, picked.id, row_number() over () - 1
  from (
    select q.id
    from public.questions q
    where q.topic_id = p_topic_id
      and q.status = 'approved'
    order by random()
    limit 7
  ) picked;

  loop
    v_attempts := v_attempts + 1;
    v_join_code := public.random_join_code(6);

    begin
      insert into public.live_duel_invites(match_id, host_id, guest_id, join_code, topic_id, status)
      values (v_match_id, auth.uid(), p_guest_id, v_join_code, p_topic_id, 'pending')
      returning id into v_invite_id;

      exit;
    exception
      when unique_violation then
        if v_attempts >= 20 then
          raise exception 'Could not generate a unique live room code';
        end if;
    end;
  end loop;

  return query
  select i.id, i.match_id, i.join_code, i.topic_id, i.expires_at
  from public.live_duel_invites i
  where i.id = v_invite_id;
end;
$$;

revoke all on function public.create_live_duel_invite(uuid, uuid) from public;
grant execute on function public.create_live_duel_invite(uuid, uuid) to authenticated;

create or replace function public.create_live_duel_invite(p_topic_id uuid)
returns table (
  invite_id uuid,
  match_id uuid,
  join_code text,
  topic_id uuid,
  expires_at timestamptz
)
language sql
volatile
security definer
set search_path = public
as $$
  select *
  from public.create_live_duel_invite(p_topic_id, null::uuid);
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
#variable_conflict use_column
declare
  v_invite public.live_duel_invites%rowtype;
  v_join_code text;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  v_join_code := upper(regexp_replace(coalesce(p_join_code, ''), '[^A-Za-z0-9]', '', 'g'));

  select i.*
  into v_invite
  from public.live_duel_invites i
  where upper(i.join_code) = v_join_code
    and i.status = 'pending'
    and i.expires_at > now()
    and (i.guest_id is null or i.guest_id = auth.uid())
  order by i.created_at desc
  limit 1
  for update;

  if v_invite.id is null then
    raise exception 'Live room not found, expired, or not addressed to you';
  end if;

  if v_invite.host_id = auth.uid() then
    raise exception 'You cannot join your own live room';
  end if;

  insert into public.match_players(match_id, user_id, player_slot)
  values (v_invite.match_id, auth.uid(), 2)
  on conflict on constraint match_players_match_id_user_id_key do nothing;

  update public.live_duel_invites i
  set guest_id = auth.uid(),
      status = 'accepted',
      accepted_at = now()
  where i.id = v_invite.id;

  update public.matches m
  set status = 'in_progress',
      started_at = coalesce(m.started_at, now())
  where m.id = v_invite.match_id
    and m.status = 'waiting';

  return query
  select i.id, i.match_id, i.host_id, i.topic_id
  from public.live_duel_invites i
  where i.id = v_invite.id;
end;
$$;

revoke all on function public.join_live_duel_invite(text) from public;
grant execute on function public.join_live_duel_invite(text) to authenticated;
