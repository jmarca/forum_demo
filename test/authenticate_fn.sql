SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test authenticate_fn!');

SELECT has_function( 'forum_example','authenticate',ARRAY['text','text'],'has authenticate function' );

SELECT function_lang_is(
    'forum_example','authenticate',ARRAY['text','text'],
    'plpgsql'
);
SELECT function_returns(
    'forum_example','authenticate',ARRAY['text','text'],
    'forum_example.jwt_token','authenticate returns jwt token'
);
SELECT volatility_is(
    'forum_example','authenticate',ARRAY['text','text'],
    'volatile'
);

SELECT is_strict(
    'forum_example','authenticate',ARRAY['text','text']
);
SELECT is_definer(
    'forum_example','authenticate',ARRAY['text','text']
);

-- temp user for testing
with newuser as ( select * from forum_example.register_user('hermann','munster','hm@munsters.com','it was a crushing bore'))
select id as hmid from newuser
\gset


prepare auth_statement as select forum_example.authenticate('hm@munsters.com','it was a crushing bore');

select ('forum_example_user',:hmid::bigint)::forum_example.jwt_token as tokenish
\gset

SELECT results_eq(
    'auth_statement',
    :tokenish::forum_example.jwt_token
);
SELECT finish();
ROLLBACK;
