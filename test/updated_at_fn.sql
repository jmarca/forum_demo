SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test updated_at_fn!');

SELECT has_function( 'forum_example_private','set_updated_at'::name,'has set_updated_at function' );

SELECT function_lang_is(
    'forum_example_private','set_updated_at'::name, 'plpgsql','set update is plpgsql');
SELECT function_returns(
    'forum_example_private','set_updated_at'::name, 'trigger'
);
SELECT volatility_is(
    'forum_example_private','set_updated_at'::name, 'volatile'
);

SELECT finish();
ROLLBACK;
