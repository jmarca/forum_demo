-- Verify forum_demo:updated_at_fn on pg

BEGIN;

SELECT has_function_privilege('forum_example_private.set_updated_at()', 'execute');

ROLLBACK;
