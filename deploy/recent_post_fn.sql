-- Deploy forum_demo:recent_post_fn to pg
-- requires: forum_schema
-- requires: posts

BEGIN;

create function forum_example.users_latest_post(u forum_example.users) returns forum_example.posts as $$
  select post.*
  from forum_example.posts as post
  where post.author_id = u.id
  order by created_at desc
  limit 1
$$ language sql stable;

comment on function forum_example.users_latest_post(forum_example.users) is 'Get’s the latest post written by the user.';

grant execute on function forum_example.users_latest_post(forum_example.users) to forum_anonymous, forum_user;


COMMIT;
