-- Revert forum_demo:accounts from pg

BEGIN;

drop table forum_example_private.user_account;

COMMIT;
