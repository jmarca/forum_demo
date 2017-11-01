-- Revert forum_demo:recent_post_fn from pg

BEGIN;

drop function forum_example.user_latest_post(forum_example.users);

COMMIT;
