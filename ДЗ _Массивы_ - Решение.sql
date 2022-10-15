-- Создать функцию, которая вычисляет средний фрахт по заданным странам (функция принимает список стран).
drop function if exists avg_fraight_for_country_array;
create or replace function avg_fraight_for_country_array(variadic counters_order text[]) returns setof text as
$$
select avg(freight)
from orders
where ship_country = any (counters_order)
group by ship_country;
$$
    language sql;
-- Отправляем списко стран.
select *
from avg_fraight_for_country_array('USA', 'Canada', 'Japan') as avg_freight;