-- Deploy forum_demo:authenticate_fn to pg
-- requires: postgraphql_roles:forum_user_role
-- requires: accounts
-- requires: forum_schema
-- requires: jwt_token_type

BEGIN;

create function forum_example.authenticate(
  email text,
  password text
) returns forum_example.jwt_token as $$
declare
  account forum_example_private.user_account;
begin
  select a.* into account
  from forum_example_private.user_account as a
  where a.email = $1;

  if account.password_hash = crypt(password, account.password_hash) then
    return ('forum_example_user', account.user_id)::forum_example.jwt_token;
  else
    return null;
  end if;
end;
$$ language plpgsql strict security definer;

comment on function forum_example.authenticate(text, text) is 'Creates a JWT token that will securely identify a user and give them certain permissions.';

COMMIT;
