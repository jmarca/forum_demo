-- Deploy forum_demo:pgcrypto to pg

BEGIN;

CREATE EXTENSION pgcrypto;

COMMIT;
