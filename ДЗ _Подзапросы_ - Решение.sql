-- 1. Вывести продукты количество которых в продаже меньше самого малого
-- среднего количества продуктов в деталях заказов (группировка по product_id).
-- Результирующая таблица должна иметь колонки product_name и units_in_stock.
select product_name, units_in_stock
from products
where units_in_stock < all (select avg(quantity)
                            from order_details
                            group by product_id
                            order by avg(quantity))
order by units_in_stock desc;
-- 2. Напишите запрос, который выводит общую сумму фрахтов заказов для
-- компаний-заказчиков для заказов, стоимость фрахта которых больше или
-- равна средней величине стоимости фрахта всех заказов, а также дата
-- отгрузки заказа должна находится во второй половине июля 1996 года.
-- Результирующая таблица должна иметь колонки customer_id и freight_sum,
-- строки которой должны быть отсортированы по сумме фрахтов заказов.
select customer_id, sum(freight) as freight_sum
from orders as o
         inner join (select customer_id, avg(freight) as freight_avg
                     from orders
                     group by customer_id) as oa
                    using (customer_id)
where freight > freight_avg
  and shipped_date between '1996-07-16' and '1996-07-31'
group by customer_id
order by freight_sum;
-- 3. Напишите запрос, который выводит 3 заказа с наибольшей стоимостью,
-- которые были созданы после 1 сентября 1997 года включительно и были
-- доставлены в страны Южной Америки. Общая стоимость рассчитывается как
-- сумма стоимости деталей заказа с учетом дисконта. Результирующая таблица
-- должна иметь колонки customer_id, ship_country и order_price, строки
-- которой должны быть отсортированы по стоимости заказа в обратном порядке.
select customer_id, ship_country, order_price
from orders
         join (select order_id, sum(unit_price * quantity - unit_price * quantity * discount) as order_price
               from order_details
               group by order_id) as od using (order_id)
where ship_country in
      ('Argentina', 'Bolivia', 'Brazil', 'Chile', 'Colombia', 'Ecuador', 'Guyana', 'Paraguay', 'Peru', 'Suriname',
       'Uruguay', 'Venezuela')
  and order_date >= '1997-09-01'
order by order_price desc
limit 3;

-- 4. Вывести все товары (уникальные названия продуктов), которых
-- заказано ровно 10 единиц (конечно же, это можно решить и без подзапроса).
select product_name
from products
where product_id = any (select product_id
                        from order_details
                        where quantity = 10);
-- Без использования подзапросов.
select distinct product_name, quantity
from products
join order_details using(product_id)
where quantity = 10;