-- Использование опретора between
-- Логика без оператора between
select *
from orders
where freight >= 20 and freight <=40;
-- Логика с оператором between
select *
from orders
where freight between 20 and 40;
