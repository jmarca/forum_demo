-- Revert forum_demo:forum_schema from pg

BEGIN;

drop schema forum_example;
drop schema forum_example_private;


COMMIT;
