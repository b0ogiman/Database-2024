create database lab1;
create table users(
    id int,
    firstname varchar(50),
    lastname varchar(50)
);

alter table users
Add  isadmin int;

alter table "users"
alter column isadmin TYPE BOOLEAN USING isadmin:: bool;

alter table "users"
alter column isadmin set default false;

ALTER TABLE users
ADD PRIMARY KEY (id);

CREATE TABLE tasks (
  id int,
  name VARCHAR(50),
  user_id INTEGER
);

DROP TABLE tasks;
DROP DATABASE lab1;
