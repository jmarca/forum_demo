-- Deploy forum_demo:accounts to pg
-- requires: forum_schema
-- requires: users

BEGIN;

create table forum_example_private.user_account (
  user_id        integer primary key references forum_example.users(id) on delete cascade,
  email            text not null unique check (email ~* '^.+@.+\..+$'),
  password_hash    text not null
);

comment on table forum_example_private.user_account is 'Private information about a user’s account.';
comment on column forum_example_private.user_account.user_id is 'The id of the user associated with this account.';
comment on column forum_example_private.user_account.email is 'The email address of the user.';
comment on column forum_example_private.user_account.password_hash is 'An opaque hash of the user’s password.';


COMMIT;
