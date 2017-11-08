-- Deploy forum_demo:current_user_fn to pg
-- requires: postgraphql_roles:forum_user_role
-- requires: accounts
-- requires: forum_schema
-- requires: authenticate_fn
-- requires: jwt_token_type

BEGIN;

create function forum_example.current_user() returns forum_example.users as $$
  select *
  from forum_example.users
  where id = current_setting('jwt.claims.user_id')::integer
$$ language sql stable;

comment on function forum_example.current_user() is 'Gets the user who was identified by our JWT.';

grant execute on function forum_example.current_user() to forum_anonymous, forum_user;

COMMIT;
