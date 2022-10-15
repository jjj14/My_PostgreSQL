-- 1. Выбрать все данные из таблицы customers
select *
from customers;

-- 2. Выбрать все записи из таблицы customers, но только колонки "имя контакта" и "город"
select contact_name, city
from customers;

-- 3. Выбрать все записи из таблицы orders, но взять две колонки: идентификатор заказа и колонку, значение в которой мы рассчитываем как разницу между датой отгрузки и датой формирования заказа.
select order_id, shipped_date - order_date
from orders;

-- 4. Выбрать все уникальные города в которых "зарегестрированы" заказчики
select distinct city
from customers;

-- 5. Выбрать все уникальные сочетания городов и стран в которых "зарегестрированы" заказчики
select distinct city, country
from customers;

-- 6. Посчитать кол-во заказчиков
select count(*)
from orders;

-- 7. Посчитать кол-во уникальных стран в которых "зарегестрированы" заказчики
select distinct country
from customers;