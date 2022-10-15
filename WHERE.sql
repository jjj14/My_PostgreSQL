-- Использование where. Фильтрация выборки.
select *
from customers
where city = 'London';
-- Выборка заказчиков из USA.
select company_name, contact_name, phone, country
from customers
where country = 'USA';
-- Выборка продуктов где цена больше или равно 20 у.е.
select *
from products
where unit_price >= 20;
-- Выборка заказчиков у которых город регистрации не Берлин.
select *
from customers
where city <> 'Berlin';
-- Выборка заказов где дата заказа больше или равна 1998-03-01.
select *
from orders
where order_date >= '1998-03-01'