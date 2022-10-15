-- Insert
create table author (
    author_id int not null,
    full_name text,
    rating float
);
-- Вставляем данные в таблицу author по всем столбцам.
insert into author
values (1, 'full_name1', 4.0);
-- Вставляем данные в таблицу author но только в столбцы author_id и full_name.
-- Можно добавлять сразу несколько значении.
insert into author(author_id, full_name)
values (3, 'full_name3'),
       (4, 'full_name4'),
       (5, 'full_name5');
-- Вывод таблицы author для просмотра результата.
select * from author;
-- Можно сразу при выборке создавать таблицу которая будет копироваться в новую. Своего рода бекап.
-- Создали и вставили в таблицу null_authors столбцы из таблицы author где rating равен null.
select *
into null_authors
from author
where rating is null;
-- Вывод таблицы null_authors для просмотра результата.
select * from null_authors;
-- Также можно добавлять данные с помощью выборки в другие таблицы.
-- В данным примере добавили остальные данные из таблицы author, где rating не null.
insert into null_authors
select *
from author
where rating is not null;
-- Проверяем таблицу. Все верно.
select * from null_authors;