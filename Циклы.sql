-- Циклы.
-- Создаем функцию используя while которая возвращает число из последовательности фиббоначи.
create or replace function fib(n int) returns int as
$$
declare
    counter int = 0;
    i       int = 0;
    j       int = 1;
begin
    if n < 1 then
        return 0;
    end if;
    while counter < n
        loop
            counter = counter + 1;
            select j, i + j into i,j;
        end loop;
    return i;
end;
$$ language plpgsql;
-- Проверяем работоспособность функции. Все работает. Вывод: 1134903170.
select fib(45);
-- Пересоздаем ту же функцую изпользуя exit when.
create or replace function fib(n int) returns int as
$$
declare
    counter int = 0;
    i       int = 0;
    j       int = 1;
begin
    if n < 1 then
        return 0;
    end if;
    loop
        exit when counter = n;
        counter = counter + 1;
        select j, i + j into i,j;
    end loop;
    return i;
end;
$$ language plpgsql;
-- Проверяем.
select fib(3);
--
create or replace function fib(n int) returns int as
$$
declare
    counter int = 0;
    i       int = 0;
    j       int = 1;
begin
    if n < 1 then
        return 0;
    end if;
    loop
        exit when counter = n;
        counter = counter + 1;
        select j, i + j into i,j;
    end loop;
    return i;
end;
$$ language plpgsql;
-- Используем do. Можно использовать reverse.
do
$$
    BEGIN
        for counter in reverse 10..1 by 2
            loop
                raise notice 'Counter %', counter;
            end loop;
    end
$$;