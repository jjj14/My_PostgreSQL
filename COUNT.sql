-- count - функция возвращающая количество записей (строк) таблицы.
select count(*)
from orders;
-- Выводим количество страх из которых сторудники.
select count(distinct country)
from employees;