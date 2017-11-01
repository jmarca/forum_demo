-- Revert forum_demo:post_summary_fn from pg

BEGIN;

drop forum_example.post_summary(forum_example.posts, int, text);

COMMIT;
