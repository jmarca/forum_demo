SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test user_functions!');

SELECT has_function( 'forum_example','user_full_name',ARRAY['forum_example.users'],'has user_full_name function' );

SELECT function_lang_is(
    'forum_example','user_full_name',ARRAY['forum_example.users'],
    'sql'
);
SELECT function_returns(
    'forum_example','user_full_name',ARRAY['forum_example.users'],
    'text'
);
SELECT volatility_is(
    'forum_example','user_full_name',ARRAY['forum_example.users'],
    'stable'
);



with
  a (id) as (
    insert into forum_example.users (first_name,last_name) values ('Hermann','Munster') returning id
  )
  select id as hermannid from a
\gset

PREPARE fun_test AS
   select forum_example.user_full_name(u) from forum_example.users u where u.id = :hermannid::bigint;


select results_eq ('fun_test',ARRAY['Hermann Munster'],'concatenated first, last name'
   );

SELECT finish();
ROLLBACK;
