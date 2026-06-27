-- Allow live matchmaking to validate open waiting rooms before joining them.
-- This prevents stale matches with missing match_questions from trapping a
-- player in bot fallback. Question content is already readable when approved;
-- this policy only exposes the fixed question IDs for open waiting matches.

create policy "match_questions_read_open_waiting"
on public.match_questions for select
to authenticated
using (
  exists (
    select 1
    from public.matches m
    where m.id = match_questions.match_id
      and m.status = 'waiting'
      and m.match_type in ('async', 'live')
  )
);
