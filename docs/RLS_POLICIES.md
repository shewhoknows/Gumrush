# RLS Policies

RLS lives in `supabase/migrations/002_phase2_rls.sql`.

Policy summary:

- Authenticated users can read active topics and approved questions.
- Authenticated users can read profiles.
- Users can insert/update only their own profile.
- Users can read matches where they are a participant.
- Users can create matches as themselves.
- Users can insert/update their own `match_players` row.
- Users can insert answers only for themselves.
- Users cannot edit questions.
- Authenticated users can insert reports.
- Leaderboard data is readable through safe profile/stat fields.

The iOS app uses only the anon key. Never expose service role keys to the client.
