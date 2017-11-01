SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test post_topic!');

SELECT has_type( 'forum_example','post_topic','has post_topic type'  );
SELECT has_enum( 'forum_example','post_topic','post_topic is an enumerated type'  );
SELECT enum_has_labels( 'forum_example', 'post_topic', ARRAY[  'discussion', 'inspiration', 'help', 'showcase'],'post_topic has expected labels' );


SELECT finish();
ROLLBACK;
