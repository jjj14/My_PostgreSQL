-- Домены
-- Создаем домен который запрещает вставку пробелов без других знаков а так же вставку null значения.
create domain text_no_space_null as text not null check (value ~ '^(?!\s*$).+');
-- Создаем таблицу agent.
create table agent
(
    first_name text_no_space_null,
    last_name  text_no_space_null
);
-- Вставляем данные в таблицу agent. Все верно. Не противоречит ограничениям.
insert into agent (first_name, last_name)
values ('2345', 'last_name');
-- Данный пример данных не будет вставлен так как значения которые мы
-- собираемся записать в first_name состоят из пробелов.
insert into agent (first_name, last_name)
values ('      ', 'last_name2');
-- Данный пример данных не будет вставлен так как значения которое мы
-- собираемся записать в first_name является null.
insert into agent (first_name, last_name)
values (null, 'last_name3');
-- Провеяем таблицу.
select *
from agent;

-- Удаляем ограничение насчет пробелов.
alter domain text_no_space_null drop constraint text_no_space_null_check;
-- Удалям таблицу если имеется.
drop table if exists agent;
-- Удаляем домен если имеется.
drop domain if exists text_no_space_null;
-- Создаем домен заново.
create domain text_no_space_null as text not null check (value ~ '^(?!\s*$).+');
-- Вставялем значения в таблицу agent.
insert into agent (first_name, last_name)
values ('23451232456765432e3423534retrgefdfewrgfe', 'last_name');
-- Добавляем в домен ограничение text_no_space_null_length32 котороя проверяет длинну текста.
-- Условие: текст не должен быть больше 32.
-- Условие вставлено но валидация для данных которые уже находятся в таблице не активно.
-- Но оно активно для новых данных вставляемых в таблицу.
alter domain text_no_space_null add constraint text_no_space_null_length32
    check (length(value) <= 32) not valid;
-- Активируем ограничение text_no_space_null_length32.
-- Данная операция говорит нам что в таблице присутствуют данные противорчащие ограничению.
alter domain text_no_space_null validate constraint text_no_space_null_length32;
-- Удаляем данные которые противоречат ограничению и снова автивируем ограничение.
-- Все верно. Теперь данный домент не будет принимать значении которые длинной больше 32.
delete
from agent
where length(first_name) > 32;

