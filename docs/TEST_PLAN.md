# Phase 2 Test Plan

## Scoring

- Correct answer earns 100 base points.
- Speed bonus is proportional to remaining time, max 50.
- Streak bonus is +25 from three correct answers in a row.
- Wrong answer earns zero.
- Timeout earns zero.
- XP calculation matches match outcome/daily/perfect bonuses.

## Match Flow

- Creates async match.
- Stores seven questions.
- Submits answers.
- Shows waiting-for-opponent when only one player completed.
- Resolves winner when both players complete.
- Bot fallback still works without backend.

## Repositories

- Local repositories work without Supabase configuration.
- Supabase config handles missing URL/key without crashing.
- Remote repositories throw friendly service errors on unavailable backend.

## Automated Now

- `QuibbleTests/ScoringServiceTests.swift` covers scoring, XP calculation, and missing Supabase config fallback.

## Remaining Automation

Add repository fake tests and two-user match-flow tests after live Supabase migrations are applied.
