-- Verify forum_demo:post_topic on pg

BEGIN;

select pg_catalog.has_type_privilege('forum_example.post_topic','usage');

ROLLBACK;
