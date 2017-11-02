-- Verify forum_demo:accounts on pg

BEGIN;

SELECT user_id, email, password_hash
  FROM forum_example_private.user_account
 WHERE FALSE;

ROLLBACK;
