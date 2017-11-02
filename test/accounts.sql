SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test accounts!');

SELECT has_table('forum_example_private','user_account','have user_account table');
SELECT has_pk('forum_example_private','user_account','user_account has pk');

SELECT has_column( 'forum_example_private', 'user_account', 'user_id','user_account has user_id col');
SELECT col_is_pk ( 'forum_example_private', 'user_account', 'user_id','user_account.user_id is pk');
SELECT fk_ok( 'forum_example_private', 'user_account', 'user_id', 'forum_example', 'users', 'id','user_account.user_id links fk to users.id' );
SELECT col_type_is( 'forum_example_private','user_account', 'user_id', 'integer','user_account.user_id is integer' );
SELECT col_not_null( 'forum_example_private','user_account','user_id','user_account.user_id is not null' );
SELECT col_hasnt_default('forum_example_private','user_account', 'user_id','user_account.user_id has no default');

SELECT has_column( 'forum_example_private', 'user_account', 'email','user_account has email col');
SELECT col_is_unique ( 'forum_example_private', 'user_account', 'email','user_account.email is unique');
SELECT col_type_is( 'forum_example_private','user_account', 'email', 'text','user_account.email is text' );
SELECT col_not_null( 'forum_example_private','user_account','email','user_account.email is not null' );
SELECT col_hasnt_default('forum_example_private','user_account', 'email','user_account.email has no default');
SELECT col_has_check('forum_example_private','user_account', 'email','user_account.email has check constraint' );

SELECT has_column( 'forum_example_private', 'user_account', 'password_hash','user_account has password_hash col');
SELECT col_type_is( 'forum_example_private','user_account', 'password_hash', 'text','user_account.password_hash is text' );
SELECT col_not_null( 'forum_example_private','user_account','password_hash','user_account.password_hash is not null' );
SELECT col_hasnt_default('forum_example_private','user_account', 'password_hash','user_account.password_hash has no default');

-- check that email check constraint works okay

with
  a (id) as (
    insert into forum_example.users (first_name,last_name) values ('Hermann','Munster') returning id
  )
  select id as hermannid from a
\gset

PREPARE broken_1  AS
   insert INTO forum_example_private.user_account (user_id,email,password_hash)
   values (:hermannid::bigint,'some dumb email', 'some dumb password');

PREPARE broken_2  AS
   insert INTO forum_example_private.user_account (user_id,email,password_hash)
   values (:hermannid::bigint,'some@dumb email', 'some dumb password');

PREPARE okay_entry  AS
   insert INTO forum_example_private.user_account (user_id,email,password_hash)
   values (:hermannid::bigint,'some@dumb.email', 'some dumb password');

select throws_ok('broken_1','23514','new row for relation "user_account" violates check constraint "user_account_email_check"','should fail email check');

select throws_ok('broken_2','23514','new row for relation "user_account" violates check constraint "user_account_email_check"','should fail email check');

select lives_ok('okay_entry','reasonable email should work');


SELECT finish();
ROLLBACK;
