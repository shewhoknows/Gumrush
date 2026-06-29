# Supabase Setup

## 1. Create Project

Create a Supabase project and copy:

- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

Do not use or ship the service role key in the iOS app.

## 2. Configure iOS App

For local development, add these values to an ignored `.xcconfig` or Xcode scheme environment:

```text
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
```

The app target maps these build settings into `Quibble/Quibble/Info.plist`, and
`SupabaseConfig` also reads runtime environment values. Use one of these safe
paths:

- Copy `Quibble/Config/Supabase.example.xcconfig` to
  `Quibble/Config/Supabase.local.xcconfig`, fill it in, and include it from your
  local Xcode configuration if desired.
- Add the two keys as scheme environment variables for simulator runs.
- Pass the two keys as `xcodebuild archive` build settings for TestFlight.

The app must continue in local demo mode if either value is missing.

## 3. Apply Migrations

Using Supabase CLI:

```bash
supabase login
supabase link --project-ref your-project-ref
supabase db push
```

Or paste the SQL in:

- `supabase/migrations/001_phase2_schema.sql`
- `supabase/migrations/002_phase2_rls.sql`
- `supabase/migrations/003_phase3_live_duels.sql`
- `supabase/migrations/004_fix_match_participant_rls_recursion.sql`
- `supabase/migrations/005_live_waiting_question_visibility.sql`
- `supabase/migrations/006_friend_codes_live_invites.sql`

Migration `006_friend_codes_live_invites.sql` is required for live friend codes,
friend requests, and code-based live duel rooms. Without it, the iOS app can
authenticate but friend-code and live-room RPC calls will fail.

## 4. Seed Data

Apply:

```bash
supabase db reset
```

Or run:

```sql
\i supabase/seed.sql
```

The seed is generated from the app's local `QuestionBank.swift` and contains the
full MVP bank: 10 topics and 1,020 approved questions, 102 per topic.

## 5. Edge Functions

Deploy server-authoritative scoring:

```bash
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
supabase functions deploy submit_match_answers
```

The service role key belongs only in Supabase function secrets. Never put it in
the iOS app, Xcode scheme, `.xcconfig`, or repo.

See `docs/EDGE_FUNCTIONS.md`.

## 6. Apple Auth

The iOS app uses native Sign in with Apple through `AuthenticationServices`,
then exchanges Apple's identity token with Supabase Auth using the ID-token
grant. The app generates a raw nonce, sends the SHA-256 hash to Apple, and sends
the raw nonce plus identity token to Supabase.

Supabase dashboard setup:

1. Open Authentication > Providers.
2. Enable Apple.
3. For native-only iOS sign-in, Supabase does not need the web OAuth Services ID
   secret rotation path, but the provider must still be enabled for ID-token
   sign-in.
4. In Apple Developer, make sure the app bundle identifier has the Sign in with
   Apple capability enabled.
5. In Xcode, keep `com.apple.developer.applesignin` enabled for the app target.

If the provider is not enabled, the app falls back gracefully and shows a
friendly auth error instead of crashing.

## Current Backend Status

The hosted Gumrush Supabase project should have migrations 001-006 applied, 10
topics, 1,020 questions, today's daily challenge, and an active
`submit_match_answers` Edge Function.
