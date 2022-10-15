-- CTE
-- Выводим company_name из suppliers где country есть в запросе "country из customers".
select company_name
from suppliers
where country in (select country
                  from customers);
-- Вывод тех же самых значении с использованием CTE.
-- Сперва создаем CTE customer_cuntries где country из customers,
-- и затем идет основной запрос company_name из suppliers где country есть в customer_cuntries.
with customer_cuntries as
         (select country
          from customers)
select company_name
from suppliers
where country in (select * from customer_cuntries);
-- Выводим данные с подзапросом без использование СТЕ.
select company_name
from suppliers
where not exists(
        select p.product_id
        from products p
                 join order_details od on p.product_id = od.product_id
                 join orders o on od.order_id = o.order_id
        where p.supplier_id = suppliers.supplier_id
          and order_date between '1998-02-01' and '1998-02-04'
    );
-- Создаем запрос который вставим в СТЕ.
select s.company_name
from products p
         join order_details od on p.product_id = od.product_id
         join orders o on od.order_id = o.order_id
         join suppliers s on p.supplier_id = s.supplier_id
where order_date between '1998-02-01' and '1998-02-04';
-- Выводим company_name из suppliers где supplier_id нет в выборке company_name и supplier_id из products
-- где order_date лежит между 1998-02-01 и 1998-02-04.
with filtered as (select s.company_name, s.supplier_id
                  from products p
                           join order_details od on p.product_id = od.product_id
                           join orders o on od.order_id = o.order_id
                           join suppliers s on p.supplier_id = s.supplier_id
                  where order_date between '1998-02-01' and '1998-02-04')
select company_name
from suppliers
where supplier_id not in (select supplier_id from filtered);