SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test users_trigger_updated!');

WITH
  u (id) as (
   insert into forum_example.users (first_name,last_name)
    values ('Hermann','Munster') returning id)
  select id as hermannid from u
\gset


-- expect that update and create times are the same




PREPARE  create_time AS
   select created_at
   from forum_example.users users
   where id = :hermannid::bigint;

PREPARE  update_time AS
   select updated_at
   from forum_example.users users
   where id = :hermannid::bigint;

select results_eq('create_time','update_time','create time and update time are the same');

-- now update the user


update forum_example.users
set about='Enjoying a delicious slice of cake'
where id = :hermannid::bigint;


select results_ne('create_time','update_time','create time and update time are different');


SELECT finish();
ROLLBACK;
