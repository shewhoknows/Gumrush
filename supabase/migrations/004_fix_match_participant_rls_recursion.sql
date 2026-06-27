-- Fix recursive match participant RLS policies.
-- Policies that query match_players from inside match_players policies can
-- recursively re-enter RLS. A small SECURITY DEFINER helper performs the
-- participant check without policy recursion.

create or replace function public.is_match_participant(target_match_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.match_players mp
    where mp.match_id = target_match_id
      and mp.user_id = auth.uid()
  );
$$;

revoke all on function public.is_match_participant(uuid) from public;
grant execute on function public.is_match_participant(uuid) to authenticated;

drop policy if exists "matches_read_participant" on public.matches;
create policy "matches_read_participant"
on public.matches for select
to authenticated
using (public.is_match_participant(id));

drop policy if exists "matches_update_participant_progress" on public.matches;
create policy "matches_update_participant_progress"
on public.matches for update
to authenticated
using (public.is_match_participant(id))
with check (
  public.is_match_participant(id)
  and status in ('waiting', 'in_progress', 'completed', 'bot_fallback')
);

drop policy if exists "match_players_read_participant" on public.match_players;
create policy "match_players_read_participant"
on public.match_players for select
to authenticated
using (public.is_match_participant(match_id));

drop policy if exists "match_questions_read_participant" on public.match_questions;
create policy "match_questions_read_participant"
on public.match_questions for select
to authenticated
using (public.is_match_participant(match_id));

drop policy if exists "player_answers_read_participant" on public.player_answers;
create policy "player_answers_read_participant"
on public.player_answers for select
to authenticated
using (public.is_match_participant(match_id));
