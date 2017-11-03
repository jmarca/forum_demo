-- Deploy forum_demo:runtime_roles to pg
-- requires: forum_schema

BEGIN;

-- create role forum_example_postgraphql;
create role forum_example_anonymous;
grant forum_example_anonymous to forum_example_postgraphql;
create role forum_example_person;
grant forum_example_person to forum_example_postgraphql;

COMMIT;
