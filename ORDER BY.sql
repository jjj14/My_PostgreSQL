-- Использование оператора order by
/* Вывод стран из которых заказчики с удалением дубликатов строк и отсортированные
по странам по возрастанию */
select distinct country
from customers
order by country;
-- Тот же запрос отсортированный по убыванию
select distinct country
from customers
order by country desc;
-- Сортировка по двум столбцам по убыванию по country и по возрастанию по city
select distinct country, city
from customers
order by country desc, city asc;
