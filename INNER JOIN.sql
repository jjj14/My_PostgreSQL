-- Использование inner join
-- Вывод product_name, company_name, units_in_stock с помощью соединения таблиц products и suppliers.
select product_name, company_name, units_in_stock
from products
inner join suppliers on products.supplier_id = suppliers.supplier_id
order by units_in_stock desc;
-- Вывод category_name из таблицы categories и суммы по units_in_stock из табицы products группируя по category_name с помощью объединения таблиц categories и products.
select category_name, sum(units_in_stock)
from categories
inner join products p on categories.category_id = p.category_id
group by category_name;
-- Вывод объединения products и categories и использованием inner join и группироваками, фильтрами, постфильтрами и арифметическими операциями.
select category_name, sum(units_in_stock * products.unit_price)
from products
inner join categories c on c.category_id = products.category_id
where discontinued <> 1
group by category_name
having sum(units_in_stock * products.unit_price) > 5000
order by sum(units_in_stock * products.unit_price) desc;
-- Вывод объединения orders, order_details, products и employees с использованием inner join.
select contact_name, company_name, phone, first_name, last_name, title,
       order_date, product_name, ship_country, p.unit_price, quantity, discount
from orders
join order_details od on orders.order_id = od.order_id
join products p on od.product_id = p.product_id
join customers c on orders.customer_id = c.customer_id
join employees e on orders.employee_id = e.employee_id
where ship_country = 'USA';
