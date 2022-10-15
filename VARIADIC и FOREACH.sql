-- Использование variadic и foreach.
create or replace function filter_even(variadic numbers int[]) returns setof int as
$$
declare
    counter int;
begin
    --for counter in 1..array_upper(numbers, 1)
    foreach counter in array numbers
        loop
            continue when counter % 2 != 0;
            return next counter;
        end loop;
end;
$$ language plpgsql;
--
select *
from filter_even(1, 2, 3, 4, 5, 6, 7, 8);