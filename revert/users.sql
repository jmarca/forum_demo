-- Revert forum_demo:users from pg

BEGIN;

drop table forum_example.users;

COMMIT;
