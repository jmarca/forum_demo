-- Deploy forum_demo:post_topic to pg
-- requires: forum_schema

BEGIN;

create type forum_example.post_topic as enum (
  'discussion',
  'inspiration',
  'help',
  'showcase'
);

COMMIT;
