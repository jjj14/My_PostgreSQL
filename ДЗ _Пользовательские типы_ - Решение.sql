-- 1. Переписать функцию, которую мы разработали ранее в одном из ДЗ таким образом,
-- чтобы функция возвращала экземпляр композитного типа. Вот та самая функция:
create or replace function get_salary_boundaries_by_city(
	emp_city varchar, out min_salary numeric, out max_salary numeric)
AS
$$
	SELECT MIN(salary) AS min_salary,
	   	   MAX(salary) AS max_salary
  	FROM employees
	WHERE city = emp_city
$$ language sql;
-- Создаем новый тип.
create type salary_min_max as (
    min_salary numeric,
    max_salary numeric
                              );
-- Переписываем функцию.
create or replace function get_salary_boundaries_by_city(emp_city varchar) returns setof salary_min_max as
$$
	SELECT MIN(salary) AS min_salary,
	   	   MAX(salary) AS max_salary
  	FROM employees
	WHERE city = emp_city
$$ language sql;
-- Пробуем вывезти. Все работает.
select * from get_salary_boundaries_by_city('London');
-- 2. Задание состоит из пунктов:
-- Создать перечисление армейских званий США, включающее следующие значения: Private, Corporal, Sergeant
create type amry_title as enum
('Private', 'Corporal', 'Sergeant');
-- Вывести все значения из перечисления.
select enum_range(null::amry_title);
-- Добавить значение Major после Sergeant в перечисление
alter type amry_title
add value 'Major' after 'Sergeant';
-- Создать таблицу личного состава с колонками: person_id, first_name, last_name, person_rank (типа перечисления)
create table lich_sostav(
    person_id serial,
    first_name text,
    last_name text,
    person_rank amry_title
);
-- Добавить несколько записей, вывести все записи из таблицы
insert into lich_sostav(first_name, last_name, person_rank)
values ('Zhanbolat', 'Orynbayev', 'Major'),
       ('Zhanbolat2', 'Orynbayev2', 'Sergeant');

select * from lich_sostav;