# Quibble Agent Notes

## Product Direction

- Preserve the existing soft neo-brutalist visual system.
- Keep abstract blob/amoeba mascots, chunky rounded cards, thick black outlines, bold black type, cream/pastel backgrounds, and tactile pill buttons.
- Do not introduce dark neon, glassmorphism, glossy 3D, casino visuals, detailed kawaii object scenes, default blue iOS buttons, or unstyled table/form screens.

## Architecture Rules

- Do not rebuild the local MVP from scratch.
- Keep backend code behind service and repository boundaries.
- Views must not call Supabase or raw networking directly.
- Preserve local/demo mode when backend configuration is absent or unreachable.
- Do not commit secrets. Use `SUPABASE_URL` and `SUPABASE_ANON_KEY` placeholders/configuration only.
- Production scoring target is server-authoritative scoring. Local scoring may remain as Phase 2 fallback, but service APIs should be shaped so an Edge Function can become authoritative later.

## Phase Boundaries

- Phase 2 includes backend-ready async 1v1 foundations, profiles, leaderboards, match history, daily challenge persistence, and offline fallback.
- Do not implement realtime multiplayer, chat, payments, ads, public user-generated questions, or public question moderation UI in Phase 2.
