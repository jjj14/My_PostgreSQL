-- Any and all
-- С использованием join
select distinct company_name
from customers
         join orders using (customer_id)
         join order_details using (order_id)
where quantity > 40;

select customer_id
from orders
         join order_details using (order_id)
where quantity > 40;
-- С использованеим подзапросов и any.
select distinct company_name
from customers
where customer_id = any (select customer_id
                         from orders
                                  join order_details using (order_id)
                         where quantity > 40);
--
select distinct product_name, quantity
from products
         join order_details using (product_id)
where quantity > (select avg(quantity)
                  from order_details)
order by quantity;
--
select distinct product_name, quantity
from products
         join order_details using (product_id)
where quantity > all (select avg(quantity)
                      from order_details
                      group by product_id
                      order by avg(quantity) desc)
order by quantity;