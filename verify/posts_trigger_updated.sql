-- Verify forum_demo:posts_trigger_updated on pg

BEGIN;

SELECT * FROM information_schema.triggers
      WHERE trigger_name = 'posts_updated_at'
        AND event_object_schema = 'forum_example'
        AND event_object_table  = 'users';

ROLLBACK;
