-- Deploy forum_demo:posts to pg
-- requires: forum_schema
-- requires: post_topic

BEGIN;

create table forum_example.posts (
  id               serial primary key,
  author_id        integer not null references forum_example.users(id),
  headline         text not null check (char_length(headline) < 280),
  body             text,
  topic            forum_example.post_topic,
  updated_at timestamp with time zone not null default now(),
  created_at       timestamp with time zone not null default now()
);



comment on table forum_example.posts is 'A forum post written by a user.';
comment on column forum_example.posts.id is 'The primary key for the post.';
comment on column forum_example.posts.headline is 'The title written by the user.';
comment on column forum_example.posts.author_id is 'The id of the author user.';
comment on column forum_example.posts.topic is 'The topic this has been posted in.';
comment on column forum_example.posts.body is 'The main body text of our post.';
comment on column forum_example.posts.updated_at is 'The time this post was last modified.';
comment on column forum_example.posts.created_at is 'The time this post was created.';

grant select on table forum_example.posts to forum_anonymous, forum_user;
grant insert, update, delete on table forum_example.posts to forum_user;
grant usage on sequence forum_example.posts_id_seq to forum_user;

alter table forum_example.posts enable row level security;
create policy select_posts on forum_example.posts for select
  using (true);

create policy insert_post on forum_example.posts for insert to forum_user
  with check (author_id = current_setting('jwt.claims.user_id')::integer);

create policy update_post on forum_example.posts for update to forum_user
  using (author_id = current_setting('jwt.claims.user_id')::integer);

create policy delete_post on forum_example.posts for delete to forum_user
  using (author_id = current_setting('jwt.claims.user_id')::integer);


COMMIT;
