-- Verify forum_demo:jwt_token_type on pg

BEGIN;

select pg_catalog.has_type_privilege('forum_example.jwt_token','usage');

ROLLBACK;
