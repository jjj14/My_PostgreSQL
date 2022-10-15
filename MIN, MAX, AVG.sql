-- Использование min, max и avg.
-- Вывод заказов из Лондона по возрастанию.
select ship_city, order_date
from orders
where ship_city = 'London'
order by order_date;
-- Вывод самого старого/минимальной даты заказа где город заказа Лондон.
select min(order_date)
from orders
where ship_city = 'London';
-- Вывод заказов из Лондона по убыванию. От самого нового заказа к самому старому.
select ship_city, order_date
from orders
where ship_city = 'London'
order by order_date desc;
-- Вывод самого нового/максимальной даты заказа где город заказа Лондон.
select max(order_date)
from orders
where ship_city = 'London';
-- Вывол средней цены продуктов которые есть в продаже. Т.е. discontinued не равно 1.
select avg(unit_price)
from products
where discontinued <> 1;
-- Вывод суммы количества продуктов которые сейчас в продаже.
select sum(units_in_stock)
from products
where discontinued <> 1;