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

## Known limitations

- The live clock is started by client coordination, not a server timestamp authority yet.
- Scoring still uses the Phase 2 client fallback unless the `submit_match_answers` Edge Function is deployed.
- Reconnect/resume is basic; a dropped room asks the user to retry.
- Presence is used only as lightweight room participation, not a full lobby roster.
- There is no chat, public room browser, friend invites, or payments.

## Phase 3 hardening next

- Move match start time and score finalization to an Edge Function.
- Add reconnect by reloading match state and replaying submitted answers.
- Add stale live match cleanup.
- Add two-device integration tests against a Supabase test project.
