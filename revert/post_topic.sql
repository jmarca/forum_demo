-- Revert forum_demo:post_topic from pg

BEGIN;

drop type forum_example.post_topic;

COMMIT;
