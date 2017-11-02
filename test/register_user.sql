SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test register_user!');

SELECT has_function( 'forum_example','register_user',ARRAY['text','text','text','text'],'has register_user function' );

SELECT function_lang_is(
    'forum_example','register_user',ARRAY['text','text','text','text'],
    'plpgsql'
);
SELECT function_returns(
    'forum_example','register_user',ARRAY['text','text','text','text'],
    'forum_example.users'
);
SELECT volatility_is(
    'forum_example','register_user',ARRAY['text','text','text','text'],
    'volatile'
);
SELECT is_strict(
    'forum_example','register_user',ARRAY['text','text','text','text']
);
SELECT is_definer(
    'forum_example','register_user',ARRAY['text','text','text','text']
);


prepare insert_statement as select forum_example.register_user('hermann','munster','hm@munsters.com','it was a crushing bore');

select lives_ok('insert_statement','able to insert user and create account');


SELECT finish();
ROLLBACK;
