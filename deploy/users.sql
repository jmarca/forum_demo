-- Deploy forum_demo:users to pg
-- requires: forum_schema

BEGIN;

SET client_min_messages = 'warning';

alter table  forum_example.users add column updated_at timestamp with time zone not null default now();

comment on column forum_example.users.updated_at is 'The time this user’s details were last modified.';

COMMIT;
