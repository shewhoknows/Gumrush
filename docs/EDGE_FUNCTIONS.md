# Edge Functions

## `submit_match_answers`

Location:

- `supabase/functions/submit_match_answers/index.ts`

This is the server-authoritative scoring path for async matches. The iOS app
calls it first for remote submissions and falls back to direct table writes only
for local/dev resilience if the function is unavailable.

1. Receive `match_id`, raw selected options, and answer times.
2. Confirm the caller is authenticated.
3. Confirm the caller is a participant in the match.
4. Fetch canonical questions and correct options from `questions`.
5. Calculate:
   - correctness
   - answer points
   - speed bonus
   - streak bonus
   - XP gained
6. Insert `player_answers`.
7. Update the caller's `match_players` row.
8. If both players completed, resolve winner and mark match `completed`.
9. Update `topic_user_stats` and `profiles.total_xp`.

## Deploy

```bash
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
supabase functions deploy submit_match_answers
```

Required secrets:

- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`

Supabase provides the first two automatically in hosted functions. Set the
service role key only in function secrets.

## Current Phase 2 Status

The Edge Function scaffold is implemented and the app is wired to call it before
using the direct PostgREST fallback. Live verification requires migrations to be
applied and the function deployed to the project.
