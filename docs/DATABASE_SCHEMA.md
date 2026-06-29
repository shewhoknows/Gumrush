# Database Schema

The Phase 2 schema lives in `supabase/migrations/001_phase2_schema.sql`. Phase 3
live duel RLS is in `003_phase3_live_duels.sql`; friend-code live challenge
support starts in `006_friend_codes_live_invites.sql`; direct friend challenge
enforcement and the join RPC ambiguity fix are in
`007_direct_friend_live_challenges.sql`; mandatory guest targeting and
open-room removal are in `008_require_direct_friend_live_challenges.sql`.

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
- `friendships`
- `friend_challenges`
- `live_duel_invites`
- `reports`

Design notes:

- `profiles.id` references `auth.users(id)`.
- `profiles.friend_code` is the public, stable, unique lookup for friends. It is
  assigned by `ensure_friend_code()`.
- Public gameplay data is read through approved/active rows.
- Match participation is modeled through `match_players`.
- Friend identity uses `profiles.friend_code`; requests and accepted friend
  links live in `friendships`.
- Code-based live rooms live in `live_duel_invites` and reuse `matches`,
  `match_players`, and `match_questions`.
- Scores and stats are stored in safe aggregate tables for leaderboards.
- Server-authoritative scoring should write `player_answers`, `match_players`,
  `topic_user_stats`, and match winner/status in one trusted server-side
  operation. Streak scoring in `submit_match_answers` is computed in
  `match_questions.question_index` order.

## Friendships (`006_friend_codes_live_invites.sql`)

`friendships(requester_id, addressee_id, status)` with `status` in
`pending | accepted | declined | cancelled`. A unique pair index on
`(least(requester_id, addressee_id), greatest(requester_id, addressee_id))`
enforces one relationship row per pair. A `check (requester_id <> addressee_id)`
prevents self-friending.

## Live duel invites (`006_friend_codes_live_invites.sql`, `007_direct_friend_live_challenges.sql`)

`live_duel_invites(join_code, host_id, guest_id, match_id, topic_id, status,
expires_at)`. Status is `pending | accepted | expired | cancelled`. `join_code`
is unique. For direct friend challenges, `guest_id` is prefilled with the
invited friend while the invite remains `pending`; only that user can join.
An atomically joined guest flips both `match.status` to `in_progress` and the
invite to `accepted`.

## Server-side RPCs (`006_friend_codes_live_invites.sql`, `008_require_direct_friend_live_challenges.sql`)

All SECURITY DEFINER with `search_path = public`, granted to `authenticated`:

- `ensure_friend_code()` -> assigns and returns the caller's friend code if missing.
- `lookup_profile_by_friend_code(p_friend_code text)` -> safe public profile
  fields.
- `send_friend_request(p_friend_code text)` -> creates a pending `friendships`
  row by friend code, returns the friendship id, rejects self-friending, and
  reuses an existing relationship row.
- `accept_friend_request(p_friendship_id uuid)` /
  `decline_friend_request(p_friendship_id uuid)` /
  `cancel_friend_request(p_friendship_id uuid)` -> transition pending state for the
  recipient or requester only.
- `create_live_duel_invite(p_topic_id uuid, p_guest_id uuid)` -> creates a `live`
  match, the host's `match_players` row, a fixed 7-question `match_questions`
  set, and the `live_duel_invites` row with a fresh `join_code`, addressed to
  the required `p_guest_id` (must be an accepted friend). The legacy
  one-argument open-room variant was dropped in migration 008.
- `join_live_duel_invite(p_join_code text)` -> atomically sets the guest,
  inserts the second `match_players` row, moves the match to `in_progress`, and
  marks the invite `accepted`. If an invite already has `guest_id`, only that
  invited user can join.

Live friend duels are networked-only: there is no bot/local fallback backend
path through these RPCs.
