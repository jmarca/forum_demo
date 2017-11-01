-- Verify forum_demo:user_functions on pg

BEGIN;

SELECT has_function_privilege('forum_example.users_full_name(forum_example.users)', 'execute');

ROLLBACK;
