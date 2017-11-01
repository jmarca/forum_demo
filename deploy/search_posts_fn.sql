-- Deploy forum_demo:search_posts_fn to pg
-- requires: forum_schema
-- requires: posts

BEGIN;

create function forum_example.search_posts(search text) returns setof forum_example.posts as $$
  select posts.*
  from forum_example.posts as posts
  where posts.headline ilike ('%' || search || '%') or posts.body ilike ('%' || search || '%')
$$ language sql stable;

comment on function forum_example.search_posts(text) is 'Returns posts containing a given search term.';

COMMIT;
