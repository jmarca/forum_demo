-- Deploy forum_demo:posts to pg
-- requires: forum_schema
-- requires: post_topic

BEGIN;

create table forum_example.post (
  id               serial primary key,
  author_id        integer not null references forum_example.users(id),
  headline         text not null check (char_length(headline) < 280),
  body             text,
  topic            forum_example.post_topic,
  created_at       timestamp default now()
);

comment on table forum_example.post is 'A forum post written by a user.';
comment on column forum_example.post.id is 'The primary key for the post.';
comment on column forum_example.post.headline is 'The title written by the user.';
comment on column forum_example.post.author_id is 'The id of the author user.';
comment on column forum_example.post.topic is 'The topic this has been posted in.';
comment on column forum_example.post.body is 'The main body text of our post.';
comment on column forum_example.post.created_at is 'The time this post was created.';

COMMIT;
