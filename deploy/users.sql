-- Deploy forum_demo:users to pg
-- requires: forum_schema

BEGIN;

SET client_min_messages = 'warning';

create table forum_example.users (
  id               serial primary key,
  first_name       text not null check (char_length(first_name) < 80),
  last_name        text check (char_length(last_name) < 80),
  about            text,
  created_at       timestamp with time zone not null default now()
);

comment on table forum_example.users is 'A user of the forum.';
comment on column forum_example.users.id is 'The primary unique identifier for the user.';
comment on column forum_example.users.first_name is 'The user’s first name.';
comment on column forum_example.users.last_name is 'The user’s last name.';
comment on column forum_example.users.about is 'A short description about the user, written by the user.';
comment on column forum_example.users.created_at is 'The time this user was created.';

COMMIT;
