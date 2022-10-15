-- 1. Выполните следующий код (записи необходимы для тестирования корректности выполнения ДЗ):
insert into customers(customer_id, contact_name, city, country, company_name)
values ('AAAAA', 'Alfred Mann', NULL, 'USA', 'fake_company'),
       ('BBBBB', 'Alfred Mann', NULL, 'Austria', 'fake_company');
-- После этого выполните задание:
-- Вывести имя контакта заказчика, его город и страну, отсортировав по возрастанию по имени контакта и городу,
-- а если город равен NULL, то по имени контакта и стране. Проверить результат, используя заранее вставленные строки.
select contact_name, city, country
from customers
order by contact_name,
         (
             case
                 when city is null then country
                 else city
                 end
             );
-- 2. Вывести наименование продукта, цену продукта и столбец со значениями
--
-- too expensive если цена >= 100
--
-- average если цена >=50 но < 100
--
-- low price если цена < 50
select product_name,
       unit_price,
       case
           when unit_price >= 100 then 'too expensive'
           when unit_price >= 50 and unit_price < 100 then 'average'
           else 'low price'
           end
from products;
-- 3. Найти заказчиков, не сделавших ни одного заказа.
-- Вывести имя заказчика и значение 'no orders' если order_id = NULL.
select contact_name,
       case
           when o.order_id::text is null then 'no orders'
           else order_id::text
           end
from customers c
         join orders o on c.customer_id = o.customer_id
where order_id is null;
-- Второй способ с использованием coalesce.
select distinct contact_name, coalesce(order_id::text, 'no orders')
from customers c
         join orders o on c.customer_id = o.customer_id
where order_id is null;
-- 4. Вывести ФИО сотрудников и их должности.
-- В случае если должность = Sales Representative вывести вместо неё Sales Stuff.
select first_name, last_name, coalesce(nullif(title, 'Sales Representative'), 'Sales Stuff')
from employees;
