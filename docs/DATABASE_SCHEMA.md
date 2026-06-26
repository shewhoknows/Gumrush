# Database Schema

The Phase 2 schema lives in `supabase/migrations/001_phase2_schema.sql`.

Core tables:

- `profiles`
- `topics`
- `questions`
- `matches`
- `match_players`
- `match_questions`
- `player_answers`
- `topic_user_stats`
- `daily_challenges`
- `daily_challenge_questions`
- `daily_challenge_results`
- `friend_challenges`
- `reports`

Design notes:

- `profiles.id` references `auth.users(id)`.
- Public gameplay data is read through approved/active rows.
- Match participation is modeled through `match_players`.
- Scores and stats are stored in safe aggregate tables for leaderboards.
- Server-authoritative scoring should write `player_answers`, `match_players`, `topic_user_stats`, and match winner/status in one trusted server-side operation.
