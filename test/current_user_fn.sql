SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test current_user_fn!');

SELECT has_function( 'forum_example','current_user'::name,'has current_user function' );

SELECT function_lang_is(
    'forum_example','current_user'::name,
    'sql', 'current user is sql'
);
SELECT function_returns(
    'forum_example','current_user'::name,
    'forum_example.users','current_user returns user'
);
SELECT volatility_is(
    'forum_example','current_user'::name,
    'stable'
);


-- temp user for testing

with newuser as ( select * from forum_example.register_user('hermann','munster','hm@munsters.com','it was a crushing bore'))
select id as hmid from newuser
\gset

set local jwt.claims.role to 'forum_user';
set local jwt.claims.user_id to :hmid;

-- now exercise the function
prepare current_user_statement as select * from  forum_example.current_user();
prepare expected_result as select * from forum_example.users where id = :hmid::bigint;

-- only testing the happy path
SELECT results_eq(
    'current_user_statement',
    'expected_result',
    'got the current user'
);



SELECT finish();
ROLLBACK;
