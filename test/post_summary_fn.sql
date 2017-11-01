SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test post_summary_fn!');

SELECT has_function( 'forum_example','post_summary',ARRAY['forum_example.posts','integer','text'],'has post_summary function' );

SELECT function_lang_is(
    'forum_example','post_summary',ARRAY['forum_example.posts','integer','text'],
    'sql'
);
SELECT function_returns(
    'forum_example','post_summary',ARRAY['forum_example.posts','integer','text'],
    'text'
);
SELECT volatility_is(
    'forum_example','post_summary',ARRAY['forum_example.posts','integer','text'],
    'stable'
);



with
  u (id) as (
    insert into forum_example.users (first_name,last_name)
    values ('Hermann','Munster') returning id
  ),
  newpost (id) as (insert INTO forum_example.posts (author_id,headline,body)
    select u.id,'A Sample Headline', 'This is the body, and less than fifty characters. This part is more than 50 characters.'
  --                                   000000000111111111122222222223333333333444444444455555555556
  --                                   123456789012345678901234567890123456789012345678901234567890
    from u
    returning id
  )
  select id as postid from newpost
\gset

PREPARE fn_test AS
   select forum_example.post_summary(posts) from forum_example.posts posts where posts.id = :postid::bigint;

PREPARE fn_test_set_length AS
   select forum_example.post_summary(posts,10) from forum_example.posts posts where posts.id = :postid::bigint;

PREPARE fn_test_set_omission AS
   select forum_example.post_summary(posts,50,'more') from forum_example.posts posts where posts.id = :postid::bigint;


select results_eq ('fn_test',ARRAY['This is the body, and less than fifty characters.…'],'summarized the body'
   );

select results_eq ('fn_test_set_length',ARRAY['This is t…'],'summarized the body to ten chars'
   );

select results_eq ('fn_test_set_omission',ARRAY['This is the body, and less than fifty characters.more'],'summarized the body, with more as omission substitution'
   );

SELECT finish();
ROLLBACK;
