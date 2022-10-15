-- Написать функцию, которая фильтрует телефонные номера по коду оператора.
-- Принимает 3-х значный код мобильного оператора и список телефонных номеров в формате +1(234)5678901 (variadic)
-- Функция возвращает только те номера, код оператора которых соответствует значению соответствующего аргумента.
-- Проверить функцию передав следующие аргументы:
-- 903, +7(903)1901235, +7(926)8567589, +7(903)1532476
-- Попробовать передать аргументы с созданием массива и без.
-- Подсказка: чтобы передать массив в VARIADIC-аргумент, надо перед массивом прописать,
-- собственно, ключевое слово variadic.
create or replace function filter_by_operator(open int, variadic numbers text[]) returns setof text as
$$
declare
    cur_val text;
begin
    foreach cur_val in array numbers
        loop
            raise notice 'Cur val as %', cur_val;
            continue when cur_val not like concat('__(', open, ')%');
            return next cur_val;
        end loop;
end;
$$
    language plpgsql;

select * from filter_by_operator(903, variadic array ['+7(903)1901235', '+7(926)8567589', '+7(903)1532456']);