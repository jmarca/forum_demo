-- Revert forum_demo:pgcrypto from pg

BEGIN;

DROP EXTENSION pgcrypto;

COMMIT;
