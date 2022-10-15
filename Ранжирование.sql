-- Ранжирование.
-- Выводим все из таблицы products.
select *
from products;
-- Выводим дополнительный столбец с нумерацией по столбцу product_id.
select product_name,
       units_in_stock,
       rank() over (order by product_id)
from products;
-- При таком же синтаксисе но при нумерации по столбцу units_in_stock выводятся номера по значению из units_in_stock
-- но следующее значение по столбцу rank() при смене значения
-- в units_in_stock будет соответствовать очередному номеру столбца.
select product_name,
       units_in_stock,
       rank() over (order by units_in_stock)
from products;
-- При использовании dense_rank при смене значения в units_in_stock значения
-- так же будут инкрементироваться по 1.
select product_name,
       units_in_stock,
       dense_rank() over (order by units_in_stock)
from products;
-- dense_rank с явным указанием какое значение должно вставлять и при каких условиях.
-- В данном случае если unit_price меньше больше 80 присваивается ранг/номер 1
-- и если unit_price больше 40 но меньше 80 то присваивается ранг/номер 2.
-- Сортируем вывод по убыванию unit_price.
select product_name,
       unit_price,
       dense_rank() over (
           order by case
                        when unit_price > 80 then 1
                        when unit_price > 30 and unit_price < 80 then 2
                        else 3
               end
           ) as ranking
from products
order by unit_price desc;
-- Данный вывод с использованием lag выводит в строке price_lag значение
-- ((предыдущее по очереди значение по unit_price) - текущее значние unit_price)
select product_name,
       unit_price,
       lag(unit_price) over (order by unit_price desc) - products.unit_price as price_lag
from products
order by unit_price desc;
-- Всталяем во вьшку moya_views данные product_name, unit_price и price_lag в котором вычисляется
-- (следующее значение по столбцу unit_price - текущее зачение по столбцу).
create or replace view moya_views as
select product_name,
       unit_price,
       lead(unit_price) over (order by unit_price) - products.unit_price as price_lag
from products
order by unit_price;

drop view moya_views;
select * from moya_views;