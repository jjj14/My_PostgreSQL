-- Декларация переменных
-- Создаем функцию которая возвращает площать триугольника.
-- Для этого создаем переменную result для того чтобы записать туда результат вычислении.
create or replace function get_square(ab real, bc real, ac real) returns real as
$$
declare
    result real;
begin
    result = (ab + bc + ac) / 2;
    return sqrt(result * (result - ab) * (result - bc) * (result - ac));
end;
$$ language plpgsql;
--
select get_square(6, 6, 6);
-- Создаем функцию которая вызвращает всю таблицу products
-- где unit_price лежит между low_price = avg_price * 0.75 и high_price = avg_price * 1.25.
create or replace function calc_middle_price() returns setof products as
$$
declare
    avg_price  real;
    low_price  real;
    high_price real;
begin
    select avg(unit_price)
    into avg_price
    from products;

    low_price = avg_price * 0.75;
    high_price = avg_price * 1.25;

    return query
        select *
        from products
        where unit_price between low_price and high_price;
end;
$$ language plpgsql;
--
select * from calc_middle_price();