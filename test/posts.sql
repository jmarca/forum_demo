SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test posts!');

select has_table('forum_example','posts','have posts table');
select has_pk('forum_example','posts','posts has pk');

SELECT has_column( 'forum_example', 'posts', 'id','posts has id col');
SELECT col_is_pk ( 'forum_example', 'posts', 'id','posts.id is pk');
SELECT col_type_is( 'forum_example','posts', 'id', 'integer','posts.id is integer' );
SELECT col_not_null( 'forum_example','posts','id','posts.id is not null' );
SELECT col_has_default('forum_example','posts', 'id','posts.id has default');

SELECT has_column( 'forum_example', 'posts', 'author_id','posts has author_id col');
SELECT fk_ok( 'forum_example', 'posts', 'author_id', 'forum_example', 'users', 'id','posts.author_id links fk to users.id' );
SELECT col_type_is( 'forum_example','posts', 'author_id', 'integer','posts.author_id is integer' );
SELECT col_not_null( 'forum_example','posts','author_id','posts.author_id is not null' );
SELECT col_hasnt_default('forum_example','posts', 'author_id','posts.author_id hasnt default');

SELECT has_column( 'forum_example','posts', 'headline','posts has headline col');
SELECT col_isnt_pk ( 'forum_example','posts', 'headline','posts.headline isnt pk');
SELECT col_type_is( 'forum_example','posts', 'headline', 'text','posts.headline is text' );
SELECT col_not_null( 'forum_example','posts', 'headline','posts.headline is not null' );
SELECT col_hasnt_default('forum_example','posts', 'headline','posts.headline hasnt default');
SELECT col_has_check('forum_example','posts', 'headline','posts.headline has check constraint' );

SELECT has_column( 'forum_example','posts', 'body','posts has body col');
SELECT col_isnt_pk ( 'forum_example','posts', 'body','posts.body isnt pk');
SELECT col_type_is( 'forum_example','posts', 'body', 'text','posts.body is text' );
-- SELECT col_not_null( 'forum_example','posts', 'body','posts.body is not null' );
SELECT col_hasnt_default('forum_example','posts', 'body','posts.body hasnt default');

SELECT has_column( 'forum_example','posts', 'topic','posts has topic col');
SELECT col_isnt_pk ( 'forum_example','posts', 'topic','posts.topic isnt pk');
SELECT col_type_is( 'forum_example','posts', 'topic', 'forum_example','post_topic','posts.topic is post_topic enum type' );
-- SELECT col_not_null( 'forum_example','posts', 'topic','posts.topic is not null' );
SELECT col_hasnt_default('forum_example','posts', 'topic','posts.topic hasnt default');

SELECT has_column( 'forum_example','posts', 'created_at','posts has created_at col');
SELECT col_isnt_pk ( 'forum_example','posts', 'created_at','posts.created_at isnt pk');
SELECT col_type_is( 'forum_example','posts', 'created_at', 'timestamp with time zone','posts.created_at is timestamp with time zone' );
SELECT col_not_null( 'forum_example','posts', 'created_at','posts.created_at is not null' );
SELECT col_has_default('forum_example','posts', 'created_at','posts.created_at has default');


-- check that headline check constraint works okay

with
  a (id) as (
    insert into forum_example.users (first_name,last_name) values ('Hermann','Munster') returning id
  )
  select id as hermannid from a
\gset

PREPARE long_headline  AS
   insert INTO forum_example.posts (author_id,headline,body)
   values (:hermannid::bigint,'A Reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaly Long Headline', 'some body');

select throws_ok('long_headline','23514','new row for relation "posts" violates check constraint "posts_headline_check"','should fail headline length check');


SELECT finish();
ROLLBACK;
