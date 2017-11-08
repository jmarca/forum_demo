-- Revert forum_demo:current_user_fn from pg

BEGIN;

drop function forum_example.current_user;

COMMIT;
