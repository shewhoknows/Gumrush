-- Gumrush Phase 3 Live Duel support.
-- Live duels reuse matches, match_players, match_questions and player_answers.
-- Realtime state travels over Supabase Realtime broadcast channels named
-- realtime:live-match-<match_id>; persisted scores still land in the tables.

-- Authenticated users can discover open waiting matches before they join.
-- Without this, RLS hides waiting rows from non-participants and matchmaking
-- can only ever create new matches.
create policy "matches_read_open_waiting"
on public.matches for select
to authenticated
using (
  status = 'waiting'
  and match_type in ('async', 'live')
);

-- Live/async participants can move a match from waiting to in_progress and then
-- completed. Production server-authoritative scoring should replace this broad
-- MVP update path with an Edge Function before public launch.
create policy "matches_update_participant_progress"
on public.matches for update
to authenticated
using (
  exists (
    select 1 from public.match_players mp
    where mp.match_id = matches.id and mp.user_id = auth.uid()
  )
)
with check (
  exists (
    select 1 from public.match_players mp
    where mp.match_id = matches.id and mp.user_id = auth.uid()
  )
  and status in ('waiting', 'in_progress', 'completed', 'bot_fallback')
);

create index if not exists idx_matches_live_waiting
on public.matches(topic_id, match_type, status, created_at)
where match_type = 'live';
