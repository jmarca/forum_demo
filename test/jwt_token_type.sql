SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test jwt_token_type!');

SELECT has_type( 'forum_example','jwt_token','has jwt_token type'  );
SELECT has_composite( 'forum_example','jwt_token','jwt_token is a composite type'  );

SELECT has_column( 'forum_example','jwt_token', 'role', 'jwt_token has role column' );
SELECT col_type_is( 'forum_example','jwt_token', 'role', 'text','jwt_token role column is type text' );

SELECT has_column( 'forum_example','jwt_token', 'user_id', 'jwt_token has user_id column' );
SELECT col_type_is( 'forum_example','jwt_token', 'user_id', 'bigint','jwt_token user_id column is type bigint' );



SELECT finish();
ROLLBACK;
