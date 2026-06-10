# Misc Projects

## Quibble (iOS app)

A fast, playful trivia battle app — **“7 questions. Endless battles.”** Native
SwiftUI iPhone app, fully local and demoable: no backend, no login, no real
multiplayer. Mock data and bot opponents only.

### Running it

Open `Quibble/Quibble.xcodeproj` in Xcode 16+ on a Mac, pick an iPhone
simulator (or your device), and hit Run. Requires iOS 17+. No dependencies,
no signing team needed for the simulator.

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
  Fitness, Science, Movies (10 mock questions each).
- **Style** — soft neo-brutalist UI (cream/pastel backgrounds, chunky rounded
  cards, thick black outlines, hard offset shadows, pill buttons) plus one
  abstract amoeba mascot drawn in code (`BlobShape` + `Canvas` faces) with nine
  expression states.
- **Persistence** — profile, XP, streaks, match history and achievements in
  `UserDefaults` via Codable.

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
