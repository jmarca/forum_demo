-- Verify forum_demo:users_trigger_updated on pg

BEGIN;

SELECT * FROM information_schema.triggers
      WHERE trigger_name = 'users_updated_at'
        AND event_object_schema = 'forum_example'
        AND event_object_table  = 'users';



ROLLBACK;
