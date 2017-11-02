-- Revert forum_demo:updated_at_fn from pg

BEGIN;

drop function forum_example_private.set_updated_at();

COMMIT;
