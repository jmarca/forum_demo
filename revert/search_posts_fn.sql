-- Revert forum_demo:search_posts_fn from pg

BEGIN;

drop function forum_example.search_posts(text);


COMMIT;
