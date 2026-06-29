# Phase 3 Live Duels

Gumrush now has a first live realtime duel path layered on top of the Phase 2 async match foundation.

## What is implemented

- Topic detail screens include `Live duel now`.
- Live matchmaking creates or joins a `matches` row with `match_type = 'live'`.
- Both players use the same 7 stored `match_questions`.
- A Supabase Realtime broadcast room is opened per match:
  - `player_ready`
  - `match_start`
  - `answer_submitted`
  - `match_finished`
  - `player_left`
- The quiz header updates when the opponent answers.
- Opponent score is updated from live answer events.
- Results wait until both players finish.
- Final answers/results are still submitted through the existing match repository path.
- If Supabase or Realtime is unavailable, the app falls back to the existing bot/local flow.
- Friend-code live challenges are backed by `live_duel_invites` and the
  `create_live_duel_invite` / `join_live_duel_invite` RPCs.
- Direct friend challenges prefill `guest_id`, so only the invited accepted
  friend can join the code.

## Migration

Apply:

```bash
supabase db push
```

or run:

```text
supabase/migrations/003_phase3_live_duels.sql
```

The migration adds RLS policies for open waiting-match discovery and participant status updates.

For friend-code room invites, also apply:

```text
supabase/migrations/006_friend_codes_live_invites.sql
supabase/migrations/007_direct_friend_live_challenges.sql
```

## Known limitations

- The live clock is started by client coordination, not a server timestamp authority yet.
- Scoring still uses the Phase 2 client fallback unless the `submit_match_answers` Edge Function is deployed.
- Reconnect/resume is basic; a dropped room asks the user to retry.
- Presence is used only as lightweight room participation, not a full lobby roster.
- There is no chat, public room browser, or payments.

## Phase 3 hardening next

- Move match start time and score finalization to an Edge Function.
- Add reconnect by reloading match state and replaying submitted answers.
- Add stale live match cleanup.
- Add two-device integration tests against a Supabase test project.
