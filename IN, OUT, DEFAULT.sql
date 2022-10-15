-- IN, OUT, DEFAULT
-- Создаем функцию которая возвращает unit_price по названию product_name которое указаывается пот вызове функции.
create or replace function get_product_price_by_name(prod_name varchar) returns real as $$
    select unit_price
    from products
    where product_name = prod_name
$$ language sql;
-- Вызываем функцию.
select get_product_price_by_name('Chocolade') as price;
-- Смотрим совпадают ли данные. Все верно.
select * from products
order by product_name;
-- Создаем функцию которая выводит максильный и минимальный unit_price.
create or replace function get_price_boundaries(out max_price real, out min_price real) as $$
    select max(unit_price), min(unit_price)
    from products
$$ language sql;
-- Вызываем функцию.
select * from get_price_boundaries();
-- Создаем функцию которая возращает максильный и минимальный unit_price по discontinued.
-- Если никакого значения не было введено параметр is_disc по умолчанию 1.
create or replace function get_price_boudaries_by_disc(is_disc int default 1, out max_price real, out min_price real) as $$
    select max(unit_price), min(unit_price)
    from products
    where discontinued = is_disc
$$ language sql;
-- Проверяем работоспособность функции. Все работает.
select * from get_price_boudaries_by_disc(1);