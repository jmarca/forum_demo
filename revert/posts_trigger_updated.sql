-- Revert forum_demo:posts_trigger_updated from pg

BEGIN;

drop trigger posts_updated_at on forum_example.posts;

COMMIT;
