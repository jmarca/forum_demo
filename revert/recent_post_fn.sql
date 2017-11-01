-- Revert forum_demo:recent_post_fn from pg

BEGIN;

drop function forum_example.users_latest_post(forum_example.users);

COMMIT;
