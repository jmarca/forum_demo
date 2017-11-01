SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test search_posts_fn!');

SELECT has_function( 'forum_example','search_posts',ARRAY['text'],'has search_posts function' );

SELECT function_lang_is(
    'forum_example','search_posts',ARRAY['text'],
    'sql'
);
SELECT function_returns(
    'forum_example','search_posts',ARRAY['text'],
    'setof forum_example.posts','returns forum example posts type'
);
SELECT volatility_is(
    'forum_example','search_posts',ARRAY['text'],
    'stable'
);

WITH
  u (id) as (
   insert into forum_example.users (first_name,last_name)
    values ('Hermann','Munster') returning id)
  select id as hermannid from u
\gset

with
  u (id) as (
    select id from forum_example.users where id = :hermannid::bigint
  ),
  oldpost (id) as (insert into forum_example.posts (author_id,headline,body)
    select u.id,'older post', 'This is the body, and less than fifty characters. However you slice it.  This part is more than 50 characters.'
    from u
    returning id
  ),
  newpost (id) as (insert INTO forum_example.posts (author_id,headline,body)
    select u.id,'newer post', 'This is the body, and less than fifty characters. This part is more than 50 characters. Final result, champ!'
    from u
    returning id
  )
  select newpost.id as newpostid, oldpost.id as oldpostid from newpost,oldpost
\gset

PREPARE fn_test AS
   select forum_example.search_posts('less than fifty characters');

PREPARE fn_test_b AS
   select forum_example.search_posts('Final result, champ!');

PREPARE  both_select AS
   select posts
   from forum_example.posts posts
   where id  IN (:newpostid::bigint,:oldpostid::bigint);

PREPARE  newest_select AS
   select posts
   from forum_example.posts posts
   where id  IN (:newpostid::bigint);

select results_eq ('fn_test','both_select','search found both posts');
select results_eq ('fn_test_b','newest_select','search found second post');


SELECT finish();
ROLLBACK;
