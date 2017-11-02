-- Deploy forum_demo:updated_at_fn to pg
-- requires: forum_schema

BEGIN;

create function forum_example_private.set_updated_at() returns trigger as $$
begin
  new.updated_at := statement_timestamp();
  return new;
end;
$$ language plpgsql;

COMMIT;
