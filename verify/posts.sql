-- Verify forum_demo:posts on pg

BEGIN;


SELECT id, author_id, headline, body, topic, created_at, updated_at
  FROM forum_example.posts
 WHERE FALSE;

ROLLBACK;
