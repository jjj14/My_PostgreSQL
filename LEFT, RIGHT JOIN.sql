-- Использование left join
select company_name, product_name
from suppliers s
left join products p on s.supplier_id = p.supplier_id;
-- 
select company_name, order_id
from customers c
left join orders o on c.customer_id = o.customer_id
where order_id is null;
--
select last_name, order_id
from employees e
left join orders o on e.employee_id = o.employee_id
where order_id is null;
--
select count(*)
from employees e
left join orders o on e.employee_id = o.employee_id
where order_id is null;
-- cross join
select *
from orders
cross join employees;
