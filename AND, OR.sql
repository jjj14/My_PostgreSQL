-- Операторы and, or
select *
from products
where unit_price > 25 and units_in_stock > 40;
-- Вывод customers из городов Berlin, London и San Francisco
select *
from customers
where city = 'Berlin' or city = 'London' or city = 'San Francisco';
-- Вывод заказов где дата отгрузки больше 1998-04-30 и вес меньше 75 а так же больше 150 одновременно.
select *
from orders
where shipped_date > '1998-04-30' and (freight < 75 or freight > 150);