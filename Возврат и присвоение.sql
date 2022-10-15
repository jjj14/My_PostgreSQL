--PLLGSQL
-- Создаем функцию get_total_number_of_goods которая возвращает сумму по units_in_stock на plpgsql.
create or replace function get_total_number_of_goods() returns bigint as
$$
begin
    return sum(units_in_stock)
        from products;
end;
$$ language plpgsql;
--
select get_total_number_of_goods();
-- Создаем фнкцию get_max_price_from_discont которая возвращает максимум по unit_price где discontinued равно 1.
create or replace function get_max_price_from_discont() returns real as
$$
begin
    return max(unit_price)
        from products
        where
    discontinued = 1;
end;
$$ language plpgsql;
--
select get_max_price_from_discont();
-- Создаем функцию с аут параметрами max_price и min_price где возвращаются значения по unit_price.
-- Записываем двуся способами.
create or replace function get_price_bound(out max_price real, out min_price real) as
$$
begin
    --max_price := max(unit_price) from products;
    --min_price := min(unit_price) from products;
    select max(unit_price), min(unit_price)
    into max_price, min_price
    from products;
end;
$$ language plpgsql;
--
select *
from get_price_bound();
-- Создаем функцию с входными параметрами которая возвращает сумму этих значений.
create or replace function get_sum(x int, y int, out result int) as
$$
begin
    result := x + y
        return;
end;
$$ language plpgsql;
--
select *
from get_sum(1, 22);
-- Создаем функцию которая возвращает таблицу customers целиком по country.
create or replace function get_cust_by_cunt(customer_country varchar) returns setof customers as
$$
begin
    return query
        select *
        from customers
        where country = customer_country;
end;
$$ language plpgsql;
--
select * from get_cust_by_cunt('USA');