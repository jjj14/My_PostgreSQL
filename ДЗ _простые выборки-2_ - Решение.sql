-- 1. Выбрать все заказы из стран France, Austria, Spain
select *
from orders
where ship_country in ('France', 'Austria', 'Spain');
-- 2. Выбрать все заказы, отсортировать по required_date (по убыванию) и отсортировать по дате отгрузке (по возрастанию)
select *
from orders
order by required_date desc, shipped_date asc;
-- 3. Выбрать минимальное кол-во  единиц товара среди тех продуктов, которых в продаже более 30 единиц.
select min(units_in_stock)
from products
where units_in_stock > 30;
-- 4. Выбрать максимальное кол-во единиц товара среди тех продуктов, которых в продаже более 30 единиц.
select max(units_in_stock)
from products
where units_in_stock > 30;
-- 5. Найти среднее значение дней уходящих на доставку с даты формирования заказа в USA
select avg(shipped_date - order_date)
from orders
where ship_country = 'USA';
-- 6. Найти сумму, на которую имеется товаров (кол-во * цену) причём таких, которые планируется продавать и в будущем (см. на поле discontinued)
select sum(units_in_stock * unit_price)
from products
where discontinued <> 1;