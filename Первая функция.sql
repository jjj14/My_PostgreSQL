-- Выводим все данные из столбца customers.
select *
from customers;
-- Создаем временную таблицу tmp_customers на основе таблицы customers.
select *
into tmp_customers
from customers;
-- Проверяем создалась ли таблица.
select *
from tmp_customers;
-- Код для обновления region если записано null на unknown.
update tmp_customers
set region = 'unknown'
where region is null;
-- Создаем функцию с именем fix_customer_region для обновления region если записано null на unknown.
create or replace function fix_customer_region() returns void as
$$
update tmp_customers
set region = 'unknown'
where region is null;
$$ language sql;
-- Вызываем функцию.
select fix_customer_region();
-- Проверяем именились ли данные. Все верно.
select *
from tmp_customers;



