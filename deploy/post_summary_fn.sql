-- Deploy forum_demo:post_summary_fn to pg
-- requires: forum_schema
-- requires: posts

BEGIN;

create function forum_example.posts_summary(
  post forum_example.posts,
  length int default 50,
  omission text default '…'
) returns text as $$
  select case
    when post.body is null then null
    else substr(post.body, 0, length) || omission
  end
$$ language sql stable;

comment on function forum_example.posts_summary(forum_example.posts, int, text) is 'A truncated version of the body for summaries.';

COMMIT;
