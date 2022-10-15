-- Выводим данные из таблицы products.
select * from products;
-- Выводим данные supplier_id, sum(units_in_stock) из таблицы products группируя по supplier_id.
select supplier_id, sum(units_in_stock)
from products
group by supplier_id
order by supplier_id;
-- Выводим данные supplier_id, sum(units_in_stock) из таблицы products группируя по supplier_id и category_id.
select supplier_id,category_id, sum(units_in_stock)
from products
group by supplier_id, category_id
order by supplier_id;
-- Выводим данные supplier_id, sum(units_in_stock) из таблицы products группируя с помощью функции grouping sets по столбцам supplier_id и category_id.
select supplier_id,category_id, sum(units_in_stock)
from products
group by grouping sets ((supplier_id), (supplier_id,category_id))
order by supplier_id, category_id nulls first;
-- Выводим данные supplier_id, sum(units_in_stock) из таблицы products группируя с помощью функции rollup по supplier_id.
select supplier_id, sum(units_in_stock)
from products
group by rollup (supplier_id);
-- Выводим данные supplier_id, sum(units_in_stock) из таблицы products группируя с помощью функции rollup по supplier_id и category_id.
select supplier_id,category_id, sum(units_in_stock)
from products
group by rollup (supplier_id, category_id)
order by supplier_id, category_id nulls first;
-- Выводим данные supplier_id, sum(units_in_stock) из таблицы products группируя с помощью функции rollup по supplier_id и category_id.
-- Сортируем по supplier_id и category_id где null выражения будут идти первыми.
select supplier_id,category_id, sum(units_in_stock)
from products
group by rollup (supplier_id, category_id)
order by supplier_id, category_id nulls first;
-- Выводим данные supplier_id, sum(units_in_stock) из таблицы products группируя с помощью функции cube по supplier_id и category_id.
-- Сортируем по supplier_id и category_id где null выражения будут идти первыми.
select supplier_id,category_id, sum(units_in_stock)
from products
group by cube (supplier_id, category_id)
order by supplier_id, category_id nulls first;