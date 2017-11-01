-- Verify forum_demo:post_summary_fn on pg

BEGIN;

SELECT has_function_privilege('forum_example.post_summary(forum_example.posts, int, text)', 'execute');


ROLLBACK;
