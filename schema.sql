-- ══════════════════════════════════════════════
--  Holy Beauty Team Task — Supabase Schema
--  Coller dans : Supabase > SQL Editor > New query
-- ══════════════════════════════════════════════

-- Membres de l'équipe
create table if not exists users (
  id         uuid default gen_random_uuid() primary key,
  name       text not null unique,
  role       text not null default 'member', -- 'admin' ou 'member'
  created_at timestamptz default now()
);

-- Tâches
create table if not exists tasks (
  id           uuid default gen_random_uuid() primary key,
  title        text not null,
  description  text default '',
  priority     int  default 3,
  status       text default 'pending',
  created_by   text not null,
  assigned_to  text default 'all',  -- 'all' = universel, sinon prénom
  due_date     date,
  due_time     time,
  created_at   timestamptz default now(),
  completed_at timestamptz,
  completed_by text
);

-- Commentaires
create table if not exists comments (
  id         uuid default gen_random_uuid() primary key,
  task_id    uuid references tasks(id) on delete cascade,
  author     text not null,
  text       text not null,
  created_at timestamptz default now()
);

-- Activer RLS (Row Level Security)
alter table users    enable row level security;
alter table tasks    enable row level security;
alter table comments enable row level security;

-- Policies : accès complet pour l'app (anon key)
create policy "open_users"    on users    for all using (true) with check (true);
create policy "open_tasks"    on tasks    for all using (true) with check (true);
create policy "open_comments" on comments for all using (true) with check (true);

-- Activer la publication real-time
alter publication supabase_realtime add table tasks;
alter publication supabase_realtime add table comments;
alter publication supabase_realtime add table users;
