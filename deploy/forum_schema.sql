-- Deploy forum_demo:forum_schema to pg

BEGIN;

create schema forum_example;
create schema forum_example_private;

grant usage on schema forum_example to forum_anonymous, forum_user;

COMMIT;
