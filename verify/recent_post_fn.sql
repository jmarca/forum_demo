-- Verify forum_demo:recent_post_fn on pg

BEGIN;

SELECT has_function_privilege('forum_example.user_latest_post(forum_example.users)', 'execute');

ROLLBACK;
