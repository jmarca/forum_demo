-- Revert forum_demo:register_user from pg

BEGIN;

drop function forum_example.register_user;

COMMIT;
