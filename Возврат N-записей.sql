-- Возврат N-записей
-- Выводим все записи из таблицы products где product_id = любой из выборки product_id, unit_price
-- и nth где row_number нумерует строки по убыванию unit_price, а так имеется фильтр nth больше 4.
select *
from products
where product_id = any (select product_id
                        from (select product_id,
                                     unit_price,
                                     row_number() over (order by unit_price desc) as nth
                              from products) sorted_prices
                        where nth < 4);
-- Почти то же самое.
select *
from (select product_id,
             product_name,
             category_id,
             unit_price,
             units_in_stock,
             row_number() over (order by unit_price desc) as nth
      from products) sorted_price
where nth < 4
order by unit_price;
-- Другое использование rank. В данном примере в столбец rank_quant вставляются
-- значения которые нумеруются по quantity по убыванию и группируюясь по order_id.
select *
from (select o.order_id,
             product_id,
             unit_price,
             quantity,
             rank() over (partition by o.order_id order by (quantity) desc) as rank_quant
      from orders o
               join order_details od on o.order_id = od.order_id) as subquert
where rank_quant <= 3;