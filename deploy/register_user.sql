-- Deploy forum_demo:register_user to pg
-- requires: forum_schema
-- requires: users
-- requires: accounts

BEGIN;

create function forum_example.register_user(
  in_first_name text,
  in_last_name text,
  in_email text,
  in_password text
) returns forum_example.users as $$
declare
  newuser forum_example.users;
begin
  with
    inserteduser  as (
      insert into forum_example.users (first_name, last_name) values
        ($1, $2)
        returning *),
    insertedaccount as (
      insert into forum_example_private.user_account (user_id, email, password_hash)
      select inserteduser.id, $3, crypt($4, gen_salt('bf'))
      from inserteduser
      returning *
    )
  select * from inserteduser
  into newuser;

  return newuser;
end;
$$ language plpgsql strict security definer;

comment on function forum_example.register_user(text, text, text, text) is 'Registers a single user and creates an account in our forum.';

grant execute on function forum_example.register_user(text, text, text, text) to forum_anonymous;

COMMIT;
