-- Coalesce and nullif
select * from orders
limit 10;
-- Использование coalesce. Если ship_region равно null то выведется unknown.
select order_id, order_date, coalesce(ship_region, 'unknown') as ship_region
from orders;
-- Если region равен null то выведется N/A.
select last_name, first_name, coalesce(region, 'N/A') as region
from employees;
-- Использование nullif. Если city равен пустой строке то вывести null.
-- Далее отрабатывает coalesce которое выведенное null значение изменяется на Unknown.
select contact_name, coalesce(nullif(city, ''), 'Unknown') as city
from customers;