-- Использование where exists
-- Вывод company_name, company_name из таблицы customers где в заказах freight between 50 and 100.
select company_name, contact_name
from customers
where exists(select customer_id
             from orders
             where customer_id = customers.customer_id
               and freight between 50 and 100);
--
select company_name, company_name
from customers
where not exists(select customer_id
                 from orders
                 where customer_id = customers.customer_id
                   and order_date between '1995-02-01' and '1995-02-15');
--
select product_name
from products
where not exists(select order_id
                 from orders
                          join order_details using (order_id)
                 where order_details.product_id = products.product_id
                   and order_date between '1995-02-01' and '1995-02-15');

