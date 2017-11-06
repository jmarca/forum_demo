-- Revert forum_demo:jwt_token_type from pg

BEGIN;

drop type forum_example.jwt_token;

COMMIT;
