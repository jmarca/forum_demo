-- Verify forum_demo:forum_schema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege('forum_example', 'usage');
SELECT pg_catalog.has_schema_privilege('forum_example_private', 'usage');

ROLLBACK;
