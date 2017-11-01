-- Deploy forum_demo:posts to pg
-- requires: forum_schema
-- requires: post_topic

BEGIN;

alter table  forum_example.posts add column updated_at timestamp with time zone not null default now();

comment on column forum_example.posts.updated_at is 'The time this post was last modified.';


COMMIT;
