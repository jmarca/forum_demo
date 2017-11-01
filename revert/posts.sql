-- Deploy forum_demo:posts to pg
-- requires: forum_schema
-- requires: post_topic

BEGIN;

alter table forum_example.posts drop column updated_at;

COMMIT;
