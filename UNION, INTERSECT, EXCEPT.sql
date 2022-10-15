-- Использование UNION, INTERSECT, EXCEPT
-- Вывод стран из которых customers и employees без дубликатов.
select country
from customers
union
select country
from employees;
-- Вывод стран из которых customers и employees с дубликатанми.
select country
from customers
union all
select country
from employees;
-- Вывод списка стран из которых одновременно и customers и suppliers без дубликатов.
select country
from customers
intersect
select country
from suppliers;
-- Вывод списка стран из которых одновременно и customers и suppliers с дубликатами.
select country
from customers
intersect all
select country
from suppliers;
-- Вывод стран в которых проживают customers но не проживают suppliers без дубликатов.
select country
from customers
except
select country
from suppliers;
-- ывод стран в которых проживают customers но не проживают suppliers с дубликатами.
select country
from customers
except all
select country
from suppliers;