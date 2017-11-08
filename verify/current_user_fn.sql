-- Verify forum_demo:current_user_fn on pg

BEGIN;

SELECT has_function_privilege('forum_example.current_user()', 'execute');

ROLLBACK;
