# Phase 2 Online Async MVP

Gumrush Phase 2 turns the local SwiftUI demo into a backend-ready async trivia duel app while preserving local/demo play.

## Current Architecture Preserved

- SwiftUI single-target iPhone app.
- `AppState` owns profile/history/challenges and persists local state with `UserDefaults`.
- `QuestionBank` and `MockData` provide local topics, questions, bots, friends, achievements, and leaderboard seeds.
- `MatchEngine` owns the 7-question timer/scoring loop and bot fallback behavior.
- Screens remain SwiftUI views using the existing soft neo-brutalist components in `Theme/` and `Components.swift`.
- Mascots remain code-drawn abstract blob shapes in `MascotView.swift`.

## Phase 2 Additions

- Supabase configuration layer with safe missing-config fallback.
- Repository protocols for topics, questions, profiles, matches, leaderboards, and daily challenges.
- Local repository implementations backed by the existing MVP data.
- Supabase repository implementations through a small PostgREST/Auth client.
- Auth/session service with guest/local mode and email/password Supabase Auth.
- Async match service API shaped for server-authoritative scoring.
- SQL migrations, RLS policies, seed data, and setup documentation.

## Online Async Flow

1. User chooses a topic.
2. Match service attempts to join a waiting match for that topic.
3. If no waiting match exists, it creates one with seven selected questions.
4. User plays their round locally through the existing `MatchEngine`.
5. The result can be submitted through `MatchService`.
6. If the remote backend is unavailable, local/bot fallback is used.

## Phase 2 Scope Decisions

- Realtime multiplayer is intentionally out of scope.
- Chat is intentionally out of scope.
- Public user-generated question flows are intentionally out of scope.
- Local scoring remains as fallback; production should move final scoring into `submit_match_answers`.
- Existing mock friend flows remain mock.

## Acceptance Snapshot

- App builds and runs without backend credentials.
- Backend credentials can be added without source edits.
- Views do not directly call Supabase.
- Local demo mode remains intact.
- Supabase schema, RLS, seeds, and setup docs exist.
- Email auth UI and account creation/sign-in service paths exist.
- Remote match create/join/question reuse/result submit paths exist.
