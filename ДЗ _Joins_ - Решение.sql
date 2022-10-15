-- 1. Найти заказчиков и обслуживающих их заказы сотрудников таких,
-- что и заказчики и сотрудники из города London, а доставка идёт
-- компанией Speedy Express. Вывести компанию заказчика и ФИО сотрудника.
select first_name || ' ' || last_name, company_name
from employees e
join orders o on e.employee_id = o.employee_id
join shippers s on o.ship_via = s.shipper_id
where company_name = 'Speedy Express' and ship_city = 'London';
-- 2. Найти активные (см. поле discontinued) продукты из категории
-- Beverages и Seafood, которых в продаже менее 20 единиц. Вывести
-- наименование продуктов, кол-во единиц в продаже, имя контакта
-- поставщика и его телефонный номер.
select product_name, units_in_stock, contact_name, phone
from products p
join categories c on p.category_id = c.category_id
join suppliers s on p.supplier_id = s.supplier_id
where category_name in ('Beverages', 'Beverages') and units_in_stock < 20;
-- 3. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.
select contact_name, order_id
from customers c
left join orders o on c.customer_id = o.customer_id
where o.customer_id is null;
-- 4. Переписать предыдущий запрос, использовав симметричный вид
-- джойна (подсказка: речь о LEFT и RIGHT).
select contact_name, order_id
from orders o
right join customers c on c.customer_id = o.customer_id
where o.customer_id is null;