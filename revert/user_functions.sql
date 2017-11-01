-- Revert forum_demo:user_functions from pg

BEGIN;

drop function forum_example.users_full_name(forum_example.users);

COMMIT;
