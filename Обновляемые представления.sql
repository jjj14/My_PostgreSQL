-- Обновляем представления.
select *
from orders;
-- Создаем представление heavy_orders по таблице orders где freight больше 50.
create view heavy_orders as
select *
from orders
where freight > 50;
-- Выводим вьюшку heavy_orders.
select *
from heavy_orders
order by freight;
-- Создаем вьюшку heavy_orders по таблице orders где freight больше 100.
create or replace view heavy_orders as
select *
from orders
where freight > 100;
-- Создаем products_suppliers_categories со столбцами из products, suppliers и categories.
create or replace view products_suppliers_categories as
select product_name,
       quantity_per_unit,
       unit_price,
       units_in_stock,
       company_name,
       contact_name,
       phone,
       category_name,
       description,
       discontinued,
       country
from products
         join suppliers using (supplier_id)
         join categories using (category_id);
-- Выводим таблицу products_suppliers_categories.
select * from products_suppliers_categories
where discontinued = 1;
-- Пробуем удалить столбец product_name из products_suppliers_categories.
-- Выдает ошибку что из вьюшку столбец удалить нельзя.
create or replace view products_suppliers_categories as
select quantity_per_unit,
       unit_price,
       units_in_stock,
       company_name,
       contact_name,
       phone,
       category_name,
       description,
       discontinued,
       country
from products
         join suppliers using (supplier_id)
         join categories using (category_id);
-- Пробуем добавить столбец address. Обрабатывается правильно.
create or replace view products_suppliers_categories as
select product_name,
       quantity_per_unit,
       unit_price,
       units_in_stock,
       company_name,
       contact_name,
       phone,
       category_name,
       description,
       discontinued,
       country,
       address
from products
         join suppliers using (supplier_id)
         join categories using (category_id);
-- Пробуем вывести. Все верно.
select * from products_suppliers_categories;




