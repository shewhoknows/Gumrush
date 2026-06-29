-- Drop the legacy one-argument open-room RPC so clients cannot create invites
-- without a targeted guest. Direct friend challenges only for now.
drop function if exists public.create_live_duel_invite(uuid);

-- Replace the two-argument RPC: p_guest_id is now REQUIRED and must be an
-- accepted friend. This is the only remaining creation path.
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

  if p_guest_id is null then
    raise exception 'A friend must be selected for a live challenge';
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

  if not exists (
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

-- Harden live_duel_invites so new direct-challenge rows require guest_id.
-- NOT VALID avoids scanning existing historical rows that may contain nulls;
-- new and updated rows are still checked.
alter table public.live_duel_invites
  add constraint chk_live_duel_invites_guest_id_required
  check (guest_id is not null)
  not valid;

-- Narrow the live duel invite read RLS policy so only the host or the targeted
-- guest can read rows directly. The SECURITY DEFINER join RPC can still look
-- up invites by code for the invited friend.
drop policy if exists "live_duel_invites_read_involved_or_joinable" on public.live_duel_invites;

create policy "live_duel_invites_read_host_or_guest"
on public.live_duel_invites for select
to authenticated
using (
  host_id = auth.uid()
  or guest_id = auth.uid()
);
