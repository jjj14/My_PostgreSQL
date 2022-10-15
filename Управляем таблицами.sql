--DDL
create table student
(
    student_id serial,
    first_name varchar,
    last_name  varchar,
    birthday   date,
    phone      varchar
);
-- Create table
create table cathedra
(
    cathedra_id   serial,
    cathedra_name varchar,
    dean          varchar
);
-- Alter table
-- Add column
alter table student
    add column middle_name varchar;

alter table student
    add column rating float;

alter table student
    add column enrolled date;
-- Drop column
alter table student
    drop column middle_name;
-- Rename table
alter table cathedra
    rename to chair;
-- Rename column
alter table chair
    rename cathedra_id to chair_id;
--
alter table chair
    rename cathedra_name to chair_name;
-- Set data type
alter table student
    alter column first_name set data type varchar(64),
    alter column last_name set data type varchar(64),
    alter column phone set data type varchar(30);
-- Create table faculty
create table faculty
(
    faculty_id   serial,
    faculty_name varchar
);
-- Работа с serial
insert into faculty (faculty_name)
values ('Faculty 1'),
       ('Faculty 2'),
       ('Faculty 3');
select * from faculty;
-- Restart identity for serial
truncate table faculty restart identity;
-- Drop table
drop table faculty;


