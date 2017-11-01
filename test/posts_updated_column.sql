SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
-- SELECT no_plan();
SELECT plan(6);
SET search_path TO forum_example,public;

SELECT pass('Test posts updated_at column!');

select has_column( 'forum_example','posts', 'updated_at','posts has updated_at col');
SELECT col_isnt_pk ( 'forum_example','posts', 'updated_at','posts.updated_at isnt pk');
SELECT col_type_is( 'forum_example','posts', 'updated_at', 'timestamp with time zone','posts.updated_at is timestamp with time zone' );
SELECT col_not_null( 'forum_example','posts', 'updated_at','posts.updated_at is not null' );
SELECT col_has_default('forum_example','posts', 'updated_at','posts.updated_at has default');

SELECT finish();
ROLLBACK;
