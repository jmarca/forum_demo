-- Verify forum_demo:register_user on pg

BEGIN;

SELECT has_function_privilege('forum_example.register_user(text, text, text, text)', 'execute');


ROLLBACK;
