-- Deploy forum_demo:posts_trigger_updated to pg
-- requires: forum_schema
-- requires: updated_at_fn
-- requires: posts

BEGIN;

create trigger posts_updated_at before update
  on forum_example.posts
  for each row
  execute procedure forum_example_private.set_updated_at();

COMMIT;
