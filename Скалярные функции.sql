-- Скалярные функции.
-- Создаем функцию get_total_number_of_goods которая возвращает сумму товаров из таблицы products.
create or replace function get_total_number_of_goods() returns bigint as
$$
select sum(units_in_stock)
from products;
$$ language sql;
-- Вызываем функцию и убеждаемся в работе.
select get_total_number_of_goods() as total_goods;
-- Создаем функцию get_avg_price которая возвращает среднюю цену товаров из таблицы products.
create or replace function get_avg_price() returns float8 as
$$
select avg(unit_price)
from products;
$$ language sql;
-- Вызываем функцию и убеждаемся в работе.
select get_avg_price() as avg_price;
