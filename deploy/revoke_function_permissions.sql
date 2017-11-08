-- Deploy forum_demo:revoke_function_permissions to pg

BEGIN;

alter default privileges revoke execute on functions from public;

COMMIT;
