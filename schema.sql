-- Run in Supabase SQL Editor. Do not expose service_role keys to the browser.
create extension if not exists pgcrypto;
create table if not exists public.admin_users (user_id uuid primary key references auth.users(id) on delete cascade);
create table if not exists public.enquiries (id uuid primary key default gen_random_uuid(),intent text not null check(intent in ('Buy VDA','Sell VDA')),name text not null check(length(name) between 1 and 150),phone text not null check(length(phone) between 8 and 25),email text not null check(length(email) between 3 and 254),location text not null check(length(location) between 1 and 200),message text not null default '' check(length(message)<=3000),status text not null default 'New' check(status in ('New','Contacted','Completed')),created_at timestamptz not null default now());
create table if not exists public.contact_enquiries (id uuid primary key default gen_random_uuid(),name text not null check(length(name) between 1 and 150),email text not null check(length(email) between 3 and 254),phone text not null default '' check(length(phone)<=25),service text not null check(length(service)<=100),message text not null default '' check(length(message)<=3000),created_at timestamptz not null default now());
alter table public.admin_users enable row level security;alter table public.enquiries enable row level security;alter table public.contact_enquiries enable row level security;
create policy "Admin can read own membership" on public.admin_users for select to authenticated using (user_id=auth.uid());
create policy "Public may submit VDA" on public.enquiries for insert to anon,authenticated with check(status='New');
create policy "Admins may read VDA" on public.enquiries for select to authenticated using(exists(select 1 from public.admin_users where user_id=auth.uid()));
create policy "Admins may update VDA" on public.enquiries for update to authenticated using(exists(select 1 from public.admin_users where user_id=auth.uid())) with check(exists(select 1 from public.admin_users where user_id=auth.uid()));
create policy "Public may submit contact" on public.contact_enquiries for insert to anon,authenticated with check(true);
create policy "Admins may read contact" on public.contact_enquiries for select to authenticated using(exists(select 1 from public.admin_users where user_id=auth.uid()));
-- After creating your admin user in Authentication > Users, run this with their UUID:
-- insert into public.admin_users(user_id) values ('YOUR_AUTH_USER_UUID');
-- Important: configure CAPTCHA / rate limiting before exposing public forms.
