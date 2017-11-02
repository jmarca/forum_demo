SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT no_plan();
-- SELECT plan(1);

SELECT pass('Test posts_trigger_updated!');

WITH
  u (id) as (
   insert into forum_example.users (first_name,last_name)
    values ('Hermann','Munster') returning id)
  select id as hermannid from u
\gset

with
  u (id) as (
    select id from forum_example.users where id = :hermannid::bigint
  ),
  oldpost (id) as (insert into forum_example.posts (author_id,headline,body)
    select u.id,'older post', 'This is the body, and less than fifty characters. However you slice it.  This part is more than 50 characters.'
    from u
    returning id
  )
  select oldpost.id as postid from oldpost
\gset

-- expect that update and create times are the same


PREPARE  create_time AS
   select created_at
   from forum_example.posts posts
   where id = :postid::bigint;

PREPARE  update_time AS
   select updated_at
   from forum_example.posts posts
   where id = :postid::bigint;

select results_eq('create_time','update_time','create time and update time are the same');


-- now update the post

update forum_example.posts
set headline='A new car!'
where id = :postid::bigint;


select results_ne('create_time','update_time','create time and update time are different');


SELECT finish();
ROLLBACK;
