-- Deploy forum_demo:users to pg
-- requires: forum_schema

BEGIN;

SET client_min_messages = 'warning';

alter table forum_example.users drop column updated_at;

COMMIT;
