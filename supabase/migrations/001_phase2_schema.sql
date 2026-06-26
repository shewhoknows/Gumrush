-- Quibble Phase 2 Online Async MVP schema.
-- Apply with Supabase CLI or the SQL editor.

create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  display_name text,
  avatar_seed text,
  total_xp integer not null default 0,
  current_streak integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.topics (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title text not null,
  subtitle text,
  description text,
  color_key text,
  icon_asset_name text,
  is_featured boolean not null default false,
  status text not null default 'active',
  created_at timestamptz not null default now()
);

create table if not exists public.questions (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid references public.topics(id),
  prompt text not null,
  option_a text not null,
  option_b text not null,
  option_c text not null,
  option_d text not null,
  correct_option text not null check (correct_option in ('A','B','C','D')),
  explanation text,
  difficulty text check (difficulty in ('easy','medium','hard')),
  status text not null default 'approved',
  created_at timestamptz not null default now()
);

create table if not exists public.matches (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid references public.topics(id),
  match_type text not null default 'async',
  status text not null default 'waiting',
  created_by uuid references public.profiles(id),
  winner_id uuid references public.profiles(id),
  created_at timestamptz not null default now(),
  started_at timestamptz,
  completed_at timestamptz
);

create table if not exists public.match_players (
  id uuid primary key default gen_random_uuid(),
  match_id uuid references public.matches(id) on delete cascade,
  user_id uuid references public.profiles(id),
  player_slot integer not null,
  score integer not null default 0,
  correct_count integer not null default 0,
  avg_answer_ms integer,
  best_streak integer not null default 0,
  xp_gained integer not null default 0,
  completed_at timestamptz,
  unique(match_id, user_id)
);

create table if not exists public.match_questions (
  id uuid primary key default gen_random_uuid(),
  match_id uuid references public.matches(id) on delete cascade,
  question_id uuid references public.questions(id),
  question_index integer not null,
  unique(match_id, question_index)
);

create table if not exists public.player_answers (
  id uuid primary key default gen_random_uuid(),
  match_id uuid references public.matches(id) on delete cascade,
  user_id uuid references public.profiles(id),
  question_id uuid references public.questions(id),
  selected_option text check (selected_option in ('A','B','C','D')),
  is_correct boolean,
  answer_ms integer,
  points integer not null default 0,
  created_at timestamptz not null default now(),
  unique(match_id, user_id, question_id)
);

create table if not exists public.topic_user_stats (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id),
  topic_id uuid references public.topics(id),
  xp integer not null default 0,
  wins integer not null default 0,
  losses integer not null default 0,
  matches_played integer not null default 0,
  best_score integer not null default 0,
  correct_answers integer not null default 0,
  total_answers integer not null default 0,
  updated_at timestamptz not null default now(),
  unique(user_id, topic_id)
);

create table if not exists public.daily_challenges (
  id uuid primary key default gen_random_uuid(),
  challenge_date date not null,
  topic_id uuid references public.topics(id),
  title text not null,
  status text not null default 'active',
  created_at timestamptz not null default now(),
  unique(challenge_date)
);

create table if not exists public.daily_challenge_questions (
  id uuid primary key default gen_random_uuid(),
  daily_challenge_id uuid references public.daily_challenges(id) on delete cascade,
  question_id uuid references public.questions(id),
  question_index integer not null
);

create table if not exists public.daily_challenge_results (
  id uuid primary key default gen_random_uuid(),
  daily_challenge_id uuid references public.daily_challenges(id),
  user_id uuid references public.profiles(id),
  score integer not null default 0,
  correct_count integer not null default 0,
  xp_gained integer not null default 0,
  completed_at timestamptz not null default now(),
  unique(daily_challenge_id, user_id)
);

create table if not exists public.friend_challenges (
  id uuid primary key default gen_random_uuid(),
  challenger_id uuid references public.profiles(id),
  challenged_id uuid references public.profiles(id),
  match_id uuid references public.matches(id),
  status text not null default 'pending',
  created_at timestamptz not null default now(),
  responded_at timestamptz
);

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  reporter_id uuid references public.profiles(id),
  question_id uuid references public.questions(id),
  match_id uuid references public.matches(id),
  reason text,
  created_at timestamptz not null default now()
);

create index if not exists idx_questions_topic_status on public.questions(topic_id, status);
create index if not exists idx_matches_topic_status on public.matches(topic_id, status);
create index if not exists idx_match_players_user on public.match_players(user_id);
create index if not exists idx_topic_stats_topic_xp on public.topic_user_stats(topic_id, xp desc);
create index if not exists idx_daily_results_challenge_score on public.daily_challenge_results(daily_challenge_id, score desc);
