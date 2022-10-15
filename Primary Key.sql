-- Создаем таблицу chair со столбцами chair_id, chair_name и dean.
create table chair
(
    chair_id serial,
    chair_name varchar,
    dean       varchar
);
-- Нельзя вставлять дубликаты в PK
insert into chair
values (1, 'Name', 'dean');

select *
from chair;
-- Нельзя вставлять null значения в PK
insert into chair
values (null, 'Name', 'dean');
-- Insert нормальных данных принимает
insert into chair
values (2, 'Name', 'dean');
-- Drop table chair
drop table chair;
-- Использование unique not null
create table chair
(
    chair_id   serial unique not null,
    chair_name varchar,
    dean       varchar
);
-- Вывод названия ограничения
select constraint_name
from information_schema.key_column_usage
where table_name = 'chair'
  and table_schema = 'public'
  and column_name = 'chair_id';
-- Удаление ограничения
alter table chair
drop constraint chair_chair_id_key;
-- Добавление ограничения primary key
alter table chair
add primary key (chair_id);