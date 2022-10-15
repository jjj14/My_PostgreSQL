-- Композитные типы
-- Мы ранее создавали функцию которая возвращает max_price и min_price из таблицы products с помощью аут параметров.
-- Удаляем данную функцию.
drop function if exists get_price_bound;
create function get_price_bound(OUT max_price real, OUT min_price real) returns record
    language plpgsql
as
$$
begin
    --max_price := max(unit_price) from products;
    --min_price := min(unit_price) from products;
    select max(unit_price), min(unit_price)
    into max_price, min_price
    from products;
end;
$$;
-- Создаем новый композитный тип данных price_bounds.
create type price_bounds as
(
    max_price real,
    min_price real
);
-- Создаем функцию которая возвращает наш ранее созданный композитный тип price_bounds.
create or replace function get_price_bound() returns setof price_bounds as
$$
select max(unit_price), min(unit_price)
from products;
$$ language sql;
-- Пробуем вывести данные. Все прекрасно работает.
select *
from get_price_bound();
-- Создаем новый композитный тип complex.
create type complex as
(
    r float8,
    i float8
);
-- Создаем таблицу math_calcs со столбцами math_id типа serial и val типа complex который мы ранее создавали.
create table math_calcs (
    math_id serial,
    val complex
);
-- Вставляем данные в столбец val.
insert into math_calcs (val)
values
(row(3.0, 4.0)),
(row(2.0, 1.0));
-- Выводим все строки из таблицы math_calcs.
select * from math_calcs;
-- Выводим только r из композитного типа val.
select (val).r
from math_calcs;
-- Выводим все значения из композитного типа.
select (val).* from math_calcs;
-- Изменяем композитный тип.
update math_calcs
set val = row(3.5, 5.0)
where math_id = 1;
-- Изменение композитного типа с математической операцией.
update math_calcs
set val.r = (val).r + 5.0
where math_id = 1;

