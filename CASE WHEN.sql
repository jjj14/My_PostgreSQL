-- Case when
-- Создаем запрос для вывода product_name, unit_price, units_in_stock и условный вывод по units_in_stock.
select product_name,
       unit_price,
       units_in_stock,
       case
           when units_in_stock >= 100 then 'lots of'
           when units_in_stock >= 50 and units_in_stock < 100 then 'average'
           when units_in_stock < 50 then 'low number'
           else 'unknown'
           end as amount
from products
order by units_in_stock desc;
-- Вывод сезонов по order_date.
select order_id,
       order_date,
       case
           when date_part('month', order_date) between 3 and 5 then 'spring'
           when date_part('month', order_date) between 6 and 8 then 'summer'
           when date_part('month', order_date) between 9 and 11 then 'autumn'
           else 'winter'
           end as season
from orders;
-- Вывод договизны продуктов по unit_price.
select product_name,
       unit_price,
       case
           when unit_price >= 30 then 'Expensive'
           when unit_price < 30 then 'Inexpensive'
           else 'unknown'
           end as price_description
from products;

