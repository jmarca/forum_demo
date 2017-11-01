SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test recent_post_fn!');

SELECT has_function( 'forum_example','user_latest_post',ARRAY['forum_example.users'],'has user_latest_post function' );

SELECT function_lang_is(
    'forum_example','user_latest_post',ARRAY['forum_example.users'],
    'sql'
);
SELECT function_returns(
    'forum_example','user_latest_post',ARRAY['forum_example.users'],
    'forum_example.posts','returns forum example posts type'
);
SELECT volatility_is(
    'forum_example','user_latest_post',ARRAY['forum_example.users'],
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
    select u.id,'older post', 'This is the body, and less than fifty characters. This part is more than 50 characters.'
    from u
    returning id
  ),
  newpost (id) as (insert INTO forum_example.posts (author_id,headline,body)
    select u.id,'newer post', 'This is the body, and less than fifty characters. This part is more than 50 characters.'
    from u
    returning id
  )
  select id as postid from newpost
\gset

PREPARE fn_test AS
   select forum_example.user_latest_post(users)
   from forum_example.users users
   where id = :hermannid::bigint;

PREPARE newest_select AS
   select posts
   from forum_example.posts posts
   where id = :postid;

select results_eq ('fn_test','newest_select','got the most recent post');


SELECT finish();
ROLLBACK;
