--IF and ELSE
-- Создаем функцию которая возвращает конывертированную температуру. Если to_celcius true, а по умолчанию оно true то значит нам пришло значение в фаренгейтах.
-- В противном же случае если false то в цельсиях. Данная функция конвертирует по заданному значению.
create or replace function convert_temp_to(temperature real, to_celcius bool default true) returns real as
$$
declare
    result_temp real;
begin
    if to_celcius then
        result_temp = (5.0 / 9.0) * (temperature - 32);
    else
        result_temp = (9 * temperature + (32 * 5)) / 5.0;
    end if;
    return result_temp;
end;
$$ language plpgsql;
-- Проверяем работоспособность функции.
select convert_temp_to(80);
--
select convert_temp_to(26.666666, false);
-- Создаем функцию которая возвращает сезон по указаному значению.
create or replace function get_season(month_number int) returns text as
$$
declare
    season text;
begin
    if month_number between 3 and 5 then
        season = 'Spring';
    elsif month_number between 6 and 8 then
        season = 'Summer';
    elsif month_number between 9 and 11 then
        season = 'Autumn';
    else
        season = 'Winter';
    end if;
    return season;
end;
$$ language plpgsql;
-- Проверяем работоспособность функции.
select distinct get_season(12);