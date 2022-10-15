-- Использование оператора in и not in
-- Способ с использованием оператора or
select *
from customers
where country = 'Mexico' or country = 'Germany' or country = 'USA' or country = 'Canada';
-- Способ с использованием оператора in
select *
from customers
where country in ('Mexico', 'Germany', 'USA', 'Canada');
-- Способ использования оператора not in. Список заказчиков которые не из USA и Canada
select *
from customers
where country not in ('USA', 'Canada');
