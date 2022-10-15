-- Оконные функции.
-- Выводим category_id, avg(unit_price) из products группируя
-- по category_id и сортируя по category_id. Лимит выводимых строк 5.
select category_id, avg(unit_price) as avg_price
from products p
group by category_id
order by category_id
limit 5;
-- Выводим данные с использованием оператора over.
select category_id,
       category_name,
       product_name,
       unit_price,
       avg(unit_price) over (partition by category_id) as avg_price
from products p
         join categories using (category_id);
--
select order_id,
       order_date,
       product_id,
       customer_id,
       unit_price                                                       as sub_total,
       sum(unit_price) over (partition by order_id order by product_id) as sale_sum
from orders
         join order_details using (order_id)
order by order_id;
--
select row_id,
       order_id,
       order_date,
       product_id,
       customer_id,
       unit_price                             as sub_total,
       sum(unit_price) over (order by row_id) as sale_sum
from (select order_id,
             order_date,
             product_id,
             customer_id,
             unit_price,
             row_number() over () as row_id
      from orders
               join order_details using (order_id)) subquery
order by order_id;