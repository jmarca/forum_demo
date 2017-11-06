-- Deploy forum_demo:jwt_token_type to pg

BEGIN;

create type forum_example.jwt_token as (
  role text,
  user_id bigint
);

COMMIT;
