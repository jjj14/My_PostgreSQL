-- Возврат наборов данных.
-- Создаем функцию которая возвращает среднее значение цены по категориям.
create or replace function get_average_price_by_prod_categ() returns setof double precision as $$
    select avg(unit_price)
    from products
    group by category_id
$$ language sql;
-- Вызываем функцию.
select * from get_average_price_by_prod_categ();
-- Создаем функцию которая возвращает сумму цен товаров и среднюю цену по категориям.
create or replace function get_avg_prices_by_cats(out sum_price real, out avg_price float8) returns setof record as $$
    select sum(unit_price), avg(unit_price)
    from products
    group by category_id
$$ language sql;
-- Вызываем функцию.
select * from get_avg_prices_by_cats();
-- Можем выводить отдельные столбцы.
select sum_price from get_avg_prices_by_cats();
-- Создаем функцию которая возвращает customer_id и company_name по стране используя returns table.
-- десь выводятся только столбцы которые были явно указаны в функции.
create or replace function get_customers_by_country(customer_country varchar)
returns table(char_code char, company_name varchar) as $$
    select customer_id, company_name
    from customers
    where country = customer_country;
$$ language sql;
-- Различные способы вывода функции.
select * from get_customers_by_country('USA');
select company_name from get_customers_by_country('USA');
-- Создаем функцию которая возвращает customer_id и company_name по стране используя returns setof "название таблицы".
-- Здесь будут выводится все столбцы из таблицы customers.
create or replace function get_customers_by_countryy(customer_country varchar)
returns setof customers as $$
    select *
    from customers
    where country = customer_country;
$$ language sql;
-- Различные способы вывода функции.
select * from get_customers_by_countryy('USA');
select company_name from get_customers_by_country('USA');
