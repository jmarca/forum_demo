-- Verify forum_demo:authenticate_fn on pg

BEGIN;

SELECT has_function_privilege('forum_example.authenticate(text,text)', 'execute');


ROLLBACK;
