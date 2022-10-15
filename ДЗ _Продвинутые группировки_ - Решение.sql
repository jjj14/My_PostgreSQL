-- Вывести сумму продаж (цена * кол-во) по каждому сотруднику с подсчётом полного итога
-- (полной суммы по всем сотрудникам) отсортировав по сумме продаж (по убыванию).
select e.first_name, sum(od.unit_price * od.quantity)
from employees e
         join orders o on e.employee_id = o.employee_id
         join order_details od on o.order_id = od.order_id
group by rollup (e.first_name)
order by sum(od.unit_price * od.quantity) desc;
select *
from orders;
select *
from order_details;
select *
from employees;
-- Вывести отчёт показывающий сумму продаж по сотрудникам и странам отгрузки с подытогами по сотрудникам
-- и общим итогом.
select e.first_name, ship_country, sum(od.unit_price * od.quantity)
from employees e
         join orders o on e.employee_id = o.employee_id
         join order_details od on o.order_id = od.order_id
group by cube (e.first_name, ship_country);
-- Вывести отчёт показывающий сумму продаж по сотрудникам, странам отгрузки,
-- сотрудникам и странам отгрузки с подытогами по сотрудникам и общим итогом.