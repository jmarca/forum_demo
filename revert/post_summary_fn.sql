-- Revert forum_demo:post_summary_fn from pg

BEGIN;

drop function forum_example.posts_summary(forum_example.posts, int, text);

COMMIT;
