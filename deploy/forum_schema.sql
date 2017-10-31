-- Deploy forum_demo:forum_schema to pg

BEGIN;

create schema forum_example;
create schema forum_example_private;

COMMIT;
