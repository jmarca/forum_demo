-- Revert forum_demo:users_trigger_updated from pg

BEGIN;

drop trigger users_updated_at on forum_example.users;

COMMIT;
