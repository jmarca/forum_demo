SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);
SET search_path TO forum_example,public;

SELECT pass('Test users!');

select has_table('forum_example','users','have users table');
select has_pk('forum_example','users','users has pk');

select has_column( 'forum_example', 'users', 'id','users has id col');
select col_is_pk ( 'forum_example', 'users', 'id','users.id is pk');
SELECT col_type_is( 'forum_example','users', 'id', 'integer','users.id is integer' );
SELECT col_not_null( 'forum_example','users','id','users.id is not null' );
SELECT col_has_default('forum_example','users', 'id','users.id has default');

SELECT has_column( 'forum_example','users', 'first_name','users has first_name col');
SELECT col_isnt_pk ( 'forum_example','users', 'first_name','users.first_name isnt pk');
SELECT col_type_is( 'forum_example','users', 'first_name', 'text','users.first_name is text' );
SELECT col_not_null( 'forum_example','users', 'first_name','users.first_name is not null' );
SELECT col_hasnt_default('forum_example','users', 'first_name','users.first_name hasnt default');
SELECT col_has_check('forum_example','users', 'first_name','users.first_name has check constraint' );

select has_column( 'forum_example','users', 'last_name','users has last_name col');
SELECT col_isnt_pk ( 'forum_example','users', 'last_name','users.last_name isnt pk');
SELECT col_type_is( 'forum_example','users', 'last_name', 'text','users.last_name is text' );
-- SELECT col_not_null( 'forum_example','users', 'last_name','users.last_name is not null' );
SELECT col_hasnt_default('forum_example','users', 'last_name','users.last_name hasnt default');
SELECT col_has_check('forum_example','users', 'last_name','users.last_name has check constraint' );

select has_column( 'forum_example','users', 'about','users has about col');
SELECT col_isnt_pk ( 'forum_example','users', 'about','users.about isnt pk');
SELECT col_type_is( 'forum_example','users', 'about', 'text','users.about is text' );
-- SELECT col_not_null( 'forum_example','users', 'about','users.about is not null' );
SELECT col_hasnt_default('forum_example','users', 'about','users.about hasnt default');

select has_column( 'forum_example','users', 'created_at','users has created_at col');
SELECT col_isnt_pk ( 'forum_example','users', 'created_at','users.created_at isnt pk');
SELECT col_type_is( 'forum_example','users', 'created_at', 'timestamp with time zone','users.created_at is timestamp with time zone' );
SELECT col_not_null( 'forum_example','users', 'created_at','users.created_at is not null' );
SELECT col_has_default('forum_example','users', 'created_at','users.created_at has default');

SELECT finish();
ROLLBACK;
