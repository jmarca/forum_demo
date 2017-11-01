-- Verify forum_demo:posts on pg

BEGIN;


SELECT id, author_id, headline, body, topic, created_at
  FROM forum_example.post
 WHERE FALSE;

ROLLBACK;
