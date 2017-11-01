-- Revert forum_demo:posts from pg

BEGIN;

drop table forum_example.posts;

COMMIT;
