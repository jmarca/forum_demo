-- Verify forum_demo:user_functions on pg

BEGIN;

SELECT has_function_privilege('forum_example.user_full_name(forum_example.users)', 'execute');

ROLLBACK;
