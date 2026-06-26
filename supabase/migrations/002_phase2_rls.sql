-- Quibble Phase 2 RLS policies.
-- These policies keep public gameplay reads available to authenticated users
-- while preventing client-side mutation of protected content.

alter table public.profiles enable row level security;
alter table public.topics enable row level security;
alter table public.questions enable row level security;
alter table public.matches enable row level security;
alter table public.match_players enable row level security;
alter table public.match_questions enable row level security;
alter table public.player_answers enable row level security;
alter table public.topic_user_stats enable row level security;
alter table public.daily_challenges enable row level security;
alter table public.daily_challenge_questions enable row level security;
alter table public.daily_challenge_results enable row level security;
alter table public.friend_challenges enable row level security;
alter table public.reports enable row level security;

-- Profiles can be read by any authenticated user for leaderboards and match history.
create policy "profiles_read_authenticated"
on public.profiles for select
to authenticated
using (true);

-- Users can create only their own profile row.
create policy "profiles_insert_own"
on public.profiles for insert
to authenticated
with check (id = auth.uid());

-- Users can update only their own profile row.
create policy "profiles_update_own"
on public.profiles for update
to authenticated
using (id = auth.uid())
with check (id = auth.uid());

-- Active topics are readable to authenticated users.
create policy "topics_read_active"
on public.topics for select
to authenticated
using (status = 'active');

-- Approved questions are readable to authenticated users.
create policy "questions_read_approved"
on public.questions for select
to authenticated
using (status = 'approved');

-- Clients cannot insert, update, or delete questions; content moderation is server/admin only.

-- Users can read matches in which they participate.
create policy "matches_read_participant"
on public.matches for select
to authenticated
using (
  exists (
    select 1 from public.match_players mp
    where mp.match_id = matches.id and mp.user_id = auth.uid()
  )
);

-- Users can create async matches as themselves.
create policy "matches_insert_self"
on public.matches for insert
to authenticated
with check (created_by = auth.uid());

-- Users can update only matches they created while waiting; final production updates should move to Edge Functions.
create policy "matches_update_creator_waiting"
on public.matches for update
to authenticated
using (created_by = auth.uid() and status = 'waiting')
with check (created_by = auth.uid());

-- Participants can read match player rows for matches they belong to.
create policy "match_players_read_participant"
on public.match_players for select
to authenticated
using (
  exists (
    select 1 from public.match_players mine
    where mine.match_id = match_players.match_id and mine.user_id = auth.uid()
  )
);

-- Users can insert only their own participant row.
create policy "match_players_insert_self"
on public.match_players for insert
to authenticated
with check (user_id = auth.uid());

-- Users can update only their own player row. Production scoring should be handled by Edge Function.
create policy "match_players_update_self"
on public.match_players for update
to authenticated
using (user_id = auth.uid())
with check (user_id = auth.uid());

-- Participants can read the fixed question list for their matches.
create policy "match_questions_read_participant"
on public.match_questions for select
to authenticated
using (
  exists (
    select 1 from public.match_players mp
    where mp.match_id = match_questions.match_id and mp.user_id = auth.uid()
  )
);

-- Match creators can insert fixed question rows for newly created matches.
create policy "match_questions_insert_creator"
on public.match_questions for insert
to authenticated
with check (
  exists (
    select 1 from public.matches m
    where m.id = match_questions.match_id and m.created_by = auth.uid()
  )
);

-- Users can read answers for matches they participate in.
create policy "player_answers_read_participant"
on public.player_answers for select
to authenticated
using (
  exists (
    select 1 from public.match_players mp
    where mp.match_id = player_answers.match_id and mp.user_id = auth.uid()
  )
);

-- Users can insert answers only for themselves.
create policy "player_answers_insert_self"
on public.player_answers for insert
to authenticated
with check (user_id = auth.uid());

-- Topic stats are readable for leaderboards.
create policy "topic_stats_read_authenticated"
on public.topic_user_stats for select
to authenticated
using (true);

-- Users can insert their own topic stat row during MVP fallback; Edge Functions should own production writes.
create policy "topic_stats_insert_self"
on public.topic_user_stats for insert
to authenticated
with check (user_id = auth.uid());

-- Users can update only their own topic stats during MVP fallback; server authority is the production target.
create policy "topic_stats_update_self"
on public.topic_user_stats for update
to authenticated
using (user_id = auth.uid())
with check (user_id = auth.uid());

-- Active daily challenges are readable.
create policy "daily_challenges_read_active"
on public.daily_challenges for select
to authenticated
using (status = 'active');

-- Daily challenge questions are readable when the parent challenge is active.
create policy "daily_challenge_questions_read_active"
on public.daily_challenge_questions for select
to authenticated
using (
  exists (
    select 1 from public.daily_challenges dc
    where dc.id = daily_challenge_questions.daily_challenge_id
      and dc.status = 'active'
  )
);

-- Users can read daily results for leaderboards.
create policy "daily_results_read_authenticated"
on public.daily_challenge_results for select
to authenticated
using (true);

-- Users can insert only their own daily result.
create policy "daily_results_insert_self"
on public.daily_challenge_results for insert
to authenticated
with check (user_id = auth.uid());

-- Users can read friend challenges that involve them.
create policy "friend_challenges_read_involved"
on public.friend_challenges for select
to authenticated
using (challenger_id = auth.uid() or challenged_id = auth.uid());

-- Users can create challenges only as the challenger.
create policy "friend_challenges_insert_self"
on public.friend_challenges for insert
to authenticated
with check (challenger_id = auth.uid());

-- Challenged users can update their own response status.
create policy "friend_challenges_update_challenged"
on public.friend_challenges for update
to authenticated
using (challenged_id = auth.uid())
with check (challenged_id = auth.uid());

-- Authenticated users can insert reports; reports are not publicly readable by clients.
create policy "reports_insert_authenticated"
on public.reports for insert
to authenticated
with check (reporter_id = auth.uid());
