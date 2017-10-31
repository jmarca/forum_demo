-- Verify forum_demo:users on pg

BEGIN;

SELECT id, first_name, last_name, about, created_at
  FROM forum_example.users
 WHERE FALSE;

ROLLBACK;
