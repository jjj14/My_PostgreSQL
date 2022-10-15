-- Check on NULL
-- Вывод ship_city, ship_region, ship_country где ship_region null.
select ship_city, ship_region, ship_country
from orders
where ship_region is null;
-- Вывод ship_city, ship_region, ship_country где ship_region не null.
select ship_city, ship_region, ship_country
from orders
where ship_region is not null;