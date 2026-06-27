# Misc Projects

## gumrush.html — playable web prototype

The same Gumrush prototype as a single self-contained HTML file — open it in
any modern browser (built iPhone-first for Safari; add to home screen for a
full-screen app feel). No build step, no server, progress saved in
`localStorage`. Identical gameplay, screens, scoring and visual style to the
iOS app below.

## Gumrush (iOS app)

A fast, playful trivia battle app — **“7 questions. Endless battles.”** Native
SwiftUI iPhone app. Phase 1 is fully local and demoable; Phase 2 adds the
foundation for Supabase-backed async 1v1 duels, profiles, leaderboards, daily
challenge persistence and local fallback.

### Running it

Open `Quibble/Quibble.xcodeproj` in Xcode 16+ on a Mac, pick an iPhone
simulator (or your device), and hit Run. Requires iOS 17+.

If `SUPABASE_URL` and `SUPABASE_ANON_KEY` are not configured, the app runs in
local/demo mode and does not crash.

### Supabase configuration

Use placeholders in source and add real values through an ignored `.xcconfig`,
Xcode scheme environment, or archive build settings:

```text
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
```

`Quibble/Config/Supabase.example.xcconfig` shows the expected keys. Copy it to
`Quibble/Config/Supabase.local.xcconfig` for local machine values, or pass the
same settings when archiving for TestFlight:

```bash
xcodebuild archive \
  -project Quibble/Quibble.xcodeproj \
  -scheme Quibble \
  -destination 'generic/platform=iOS' \
  SUPABASE_URL=https://your-project.supabase.co \
  SUPABASE_ANON_KEY=your-anon-key
```

Never commit service role keys.

### Supabase setup

Schema, RLS and seeds live in:

- `supabase/migrations/001_phase2_schema.sql`
- `supabase/migrations/002_phase2_rls.sql`
- `supabase/seed.sql`

The seed is generated from the local Swift question bank and includes 1,020
questions across the 10 MVP topics.

Apply with:

```bash
supabase db push
```

or run the SQL manually in the Supabase SQL editor.

### Tests

Run the app tests with:

```bash
xcodebuild test -project Quibble/Quibble.xcodeproj -scheme Quibble -destination 'platform=iOS Simulator,name=iPhone 17'
```

`QuibbleTests` currently covers scoring and missing Supabase config fallback.
See `docs/TEST_PLAN.md` for the remaining Phase 2 match-flow and repository
cases to automate.

### What's inside

- **Gameplay** — 7-question duels vs bot blobs, 4 options, 10 seconds per
  question. Scoring: 100 per correct answer, up to +50 speed bonus, +25 streak
  bonus from 3 correct in a row. XP: +120 win / +60 loss, +50 daily challenge,
  +50 perfect 7.
- **Screens** — Welcome, Choose Topics, Home, All Topics, Topic Detail,
  Matchmaking, Quiz, Answer Feedback, Results, Review Answers, Leaderboard,
  Profile, Activity/Match History, Challenge Friend (mock), Daily Challenge,
  Streak & Achievements.
- **Topics** — Cricket, Bollywood, Tech, Geography, Food, History, Music,
  Fitness, Science, Movies.
- **Style** — soft neo-brutalist UI (cream/pastel backgrounds, chunky rounded
  cards, thick black outlines, hard offset shadows, pill buttons) plus one
  abstract amoeba mascot drawn in code (`BlobShape` + `Canvas` faces) with nine
  expression states.
- **Persistence** — profile, XP, streaks, match history and achievements in
  `UserDefaults` via Codable, with Phase 2 repository/service boundaries ready
  for Supabase-backed persistence.
- **Live duels** — Supabase Realtime room events for ready/start/answer/finish
  sync, plus the existing bot fallback when live rooms are unavailable.

### Phase 2 implemented foundation

- Supabase schema, RLS and seed files.
- Full 1,020-question Supabase seed generated from the local app bank.
- Safe missing-config fallback.
- Auth/session service with guest/local mode, email/password Supabase Auth, and
  native Sign in with Apple token exchange for Supabase Auth.
- Repository protocols and local/Supabase implementations.
- Async match create/join/submit APIs with bot fallback.
- Server-authoritative match submission Edge Function scaffold, with iOS app
  invocation before direct table-write fallback.
- Daily challenge fetch/submit and leaderboard service boundaries.
- Waiting-for-opponent Activity state.
- Documentation for setup, RLS, schema, Edge Functions and limitations.

### Phase 3 live duel foundation

- Topic detail screens expose `Live duel now`.
- Live matchmaking uses `match_type = 'live'` and the same fixed 7-question
  match question set for both players.
- Supabase Realtime broadcast channels sync player ready, match start, answer
  submitted, match finished and player-left events.
- Results wait until both live players finish before resolving the outcome.
- `supabase/migrations/003_phase3_live_duels.sql` adds the RLS policies needed
  for live waiting-match discovery and participant status updates.

### Next steps

- Apply migrations and seed data to the live Supabase project.
- Deploy `submit_match_answers` and run two-device async/live duel smoke tests.
- Expand `QuibbleTests` to cover repository fakes and match flow.
- Add real friend graph/challenges if desired.
- Finish production auth provider settings and account recovery flows.

## fitness-plan.html

A self-contained 3-week fitness tracking page (May 21 – June 12, 2026). Just
open the file in any modern browser — no build step, no server.

### Features

- **Daily checklist** for strength workouts and 30-minute walks
- **Weigh-in tracking** on Day 1, two mid-cycle checkpoints, and the final day
- **Live progress bar** showing percentage of completed sessions
- **Latest weight display** with delta from target
- **Today's row** highlighted automatically and scrolled into view
- **Completed days** marked with a green left border once both checkboxes are ticked
- **localStorage persistence** — your progress survives page reloads
- **Dark mode** via `prefers-color-scheme`
- **Print-friendly** stylesheet for a clean paper copy
- **Accessible** — labeled checkboxes/inputs and visible focus rings

### Routines

Four bodyweight circuits are detailed at the bottom of the page:

- **Routine A** — Lower + Core
- **Routine B** — Upper + Core
- **Routine C** — Glutes & Legs
- **Routine D** — Pilates Core

Each is 3 rounds with 30–45s rest between exercises.

### Resetting

Use the **Reset all data** button to clear saved progress and weight entries
(asks for confirmation).
