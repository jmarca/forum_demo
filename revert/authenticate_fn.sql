-- Revert forum_demo:authenticate_fn from pg

BEGIN;

drop function forum_example.authenticate;

COMMIT;
