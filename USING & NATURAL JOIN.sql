-- Вывод объединения orders, order_details, products и employees с использованием inner join и фильтрами.
select contact_name, company_name, phone, first_name, last_name, title,
       order_date, product_name, ship_country, p.unit_price, quantity, discount
from orders o
join order_details od using(order_id)
join products p using(product_id)
join customers c using(customer_id)
join employees e using(employee_id)
where ship_country = 'USA';
-- natural join.
select order_id, customer_id, first_name, last_name, title
from orders
natural join employees;

