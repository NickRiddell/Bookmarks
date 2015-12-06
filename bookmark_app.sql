drop table bookmarks;
create table bookmarks (
  id serial8 primary key,
  url VARCHAR(255),
  genre VARCHAR(255),
  info text
);