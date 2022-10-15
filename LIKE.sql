-- Использование like
-- Вывод last_name, first_name где first_name заканчивается на n.
select last_name, first_name
from employees
where first_name like '%n';
-- Вывод last_name, first_name где last_name начинается на B.
select last_name, first_name
from employees
where last_name like 'B%';
-- Вывод last_name, first_name где last_name начинается на один любой символ затем идет uch и далее любые символы.
select last_name, first_name
from employees
where last_name like '_uch%';