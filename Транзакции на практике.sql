-- Транзакции.
-- Начинаем транзакцию.
begin transaction isolation level serializable;
-- Создаем точку сохранения.
savepoint save;
-- Делаем изменения в employees.
update employees
set salary = salary * 1.5
where salary < 1000;
-- Делаем изменения в employees.
update employees
set salary = salary * 1.5
where salary > 1000;
-- Возвращаемся к точке сохранения и отменяем все изменения после нее.
rollback to save;
-- Заканчиваем транзакцию.
commit;
-- Начинаем транзакцию.
begin transaction isolation level serializable;
-- Всталявем данные из order_details где product_id есть в CTE prod_update в создаваемую таблицу
-- last_orders_on_discontinued
with prod_update as (
    update products
        set discontinued = 1
        where units_in_stock < 10
        returning product_id)
select *
into last_orders_on_discontinued
from order_details
where product_id in (select product_id from prod_update);
-- Создаем точку сохранения backup.
savepoint backup;
-- Удаляем данные из order_details где product_id имеется в last_orders_on_discontinued.
delete
from order_details
where product_id in (select product_id from last_orders_on_discontinued);
-- Возвращаемся к точке сохранения backup и тем самым отменяем все действия после точки сохранения.
rollback to backup;
-- Создаем точку сохранения.
savepoint backup1;
-- Обновляем данные quantity в order_details на 0 где product_id есть в таблице last_orders_on_discontinued.
update order_details
set quantity = 0
where product_id in (select product_id from last_orders_on_discontinued);
-- Возвращаемся к точке сохранения backup и тем самым отменяем все действия после точки сохранения.
rollback to backup1;
-- Завершаем транзакцию.
commit;
-- Для проверки по удалению данных из order_details.
select count(*)
from order_details;
-- Для проверки создания last_orders_on_discontinued.
select *
from last_orders_on_discontinued;