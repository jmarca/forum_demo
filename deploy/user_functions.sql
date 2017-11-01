-- Deploy forum_demo:user_functions to pg
-- requires: forum_schema
-- requires: users

BEGIN;

create function forum_example.users_full_name(u forum_example.users) returns text as $$
  select u.first_name || ' ' || u.last_name
$$ language sql stable;

comment on function forum_example.users_full_name(forum_example.users) is 'A user’s full name which is a concatenation of their first and last name.';

COMMIT;
