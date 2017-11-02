-- Deploy forum_demo:users_trigger_updated to pg
-- requires: forum_schema
-- requires: updated_at_fn
-- requires: users

BEGIN;

create trigger users_updated_at before update
  on forum_example.users
  for each row
  execute procedure forum_example_private.set_updated_at();

COMMIT;
