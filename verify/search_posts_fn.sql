-- Verify forum_demo:search_posts_fn on pg

BEGIN;

SELECT has_function_privilege('forum_example.search_posts(text)', 'execute');


ROLLBACK;
