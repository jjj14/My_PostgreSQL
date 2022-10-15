--1. В рамках транзакции с уровнем изоляции Repeatable Read выполнить следующие операции:
-- заархивировать (SELECT INTO или CREATE TABLE AS) заказчиков, которые сделали покупок менее чем на 2000 у.е.
-- удалить из таблицы заказчиков всех заказчиков, которые были предварительно заархивированы
-- (подсказка: для этого придётся удалить данные из связанных таблиц)

begin transaction isolation level repeatable read;
drop table if exists archive_customers;

create table archive_customers as
select customer_id, company_name, sum(unit_price * quantity) as total
from orders
         join order_details using (order_id)
         join customers using (customer_id)
group by company_name, customer_id
having sum(unit_price * quantity) < 2000
order by sum(unit_price * quantity) desc;

delete
from order_details
where order_id in (select order_id
                   from orders
                   where customer_id in
                         (select customer_id from archive_customers));

delete
from orders
where customer_id in (select customer_id from archive_customers);

delete
from customers
where customer_id in (select customer_id from archive_customers);

commit;
-- 2. В рамках транзакции выполнить следующие операции:
-- - заархивировать все продукты, снятые с продажи (см. колонку discontinued)
-- - поставить savepoint после архивации
-- - удалить из таблицы продуктов все продукты, которые были заархивированы
-- - откатиться к savepoint
-- - закоммитить тразнакцию
begin transaction isolation level serializable;
drop table if exists backedup_prod;

create table backedup_prod as
select *
from products
where discontinued = 1;

savepoint save1;

delete from products
where product_id in (select product_id from backedup_prod);

rollback to save1;

commit;

select count(*) from products;