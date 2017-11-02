-- Deploy forum_demo:register_user to pg
-- requires: forum_schema
-- requires: users
-- requires: accounts

BEGIN;

create function forum_example.register_user(
  first_name text,
  last_name text,
  email text,
  password text
) returns forum_example.users as $$
declare
  users forum_example.users;
begin
  with
    newuser  as (
      insert into forum_example.users (first_name, last_name) values
        (first_name, last_name)
        returning *),
    newaccount as (
      insert into forum_example_private.user_account (user_id, email, password_hash)
      select newuser.id, email, crypt(password, gen_salt('bf'))
      from newuser
    )
    select * from newuser
    into users;

  return users;
end;
$$ language plpgsql strict security definer;

comment on function forum_example.register_user(text, text, text, text) is 'Registers a single user and creates an account in our forum.';

COMMIT;
