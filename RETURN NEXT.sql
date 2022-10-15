-- RETURN NEXT
-- Выводим 1, 2 и 3 с помощью return next.
create or replace function return_int() returns setof int as
$$
begin
    return next 1;
    return next 2;
    return next 3;
    --return;
end;
$$ language plpgsql;
--
select *
from return_int();
-- Создаем функцию которая меняет цены на товары которые входят в опреденные категории на определенный коэффицент
-- с использованием return next добавляет данные в переменную product типа record.
create or replace function after_chr_sale() returns setof products as
$$
declare
    product record;
begin
    for product in select * from products
        loop
            if product.category_id in (1, 4, 8) then
                product.unit_price = product.unit_price * 0.8;
            elsif product.category_id in (2, 3, 7) then
                product.unit_price = product.unit_price * 0.75;
            else
                product.unit_price = product.unit_price * 1.1;
            end if;
            return next product;
        end loop;

end;
$$ language plpgsql;
-- Проверяем вывод.
select * from after_chr_sale();