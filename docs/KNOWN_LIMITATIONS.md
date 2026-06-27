# Known Limitations

- Supabase remote repositories are implemented for the Phase 2 contract, but full production hardening requires integration testing after migrations are applied to the live project.
- `submit_match_answers` exists and the app calls it first for remote submissions, but the live function still needs to be deployed.
- Phase 3 live duels use Supabase Realtime broadcast for room events. Server-authoritative start timing, reconnect replay, and final score authority still need Edge Function hardening before public launch.
- Final match scoring is still locally computed in the iOS fallback path when the Edge Function is unavailable.
- Email/password auth is implemented. Magic link and Apple Sign In as a Supabase provider need project-specific Supabase Auth/provider configuration.
- Friend challenges remain scaffolded/mock.
- Weekly leaderboard aggregation is intentionally minimal.
- No realtime multiplayer, chat, payments, ads, or public question authoring.
- A first `QuibbleTests` target exists for scoring/config checks. Broader repository and two-user integration tests still need to be added after live Supabase setup.
