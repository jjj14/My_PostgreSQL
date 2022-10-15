-- Check во вьюшках.
-- Создаем вьюшку.
create or replace view heavy_orders as
select *
from orders
where freight > 100;
-- Смотрим вывод.
select *
from heavy_orders
order by freight;
-- При создании вьюшки мы добавили туда данные где freight больше 100.
-- Пробудем добавить столбец где freight меньше 100. Все сработало нормально.
insert into heavy_orders (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via,
                          freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country)
values (11122, 'ERNSH', 3, '1998-01-27', '1998-01-27', '1998-01-27', 2, 88, 'Handel', 'Kirchgasse 6', 'Graz',
        'Lara', 8010, 'Austria');
-- Смотрим добавились ли данные. Да, данные добавлены.
select *
from orders
where order_id = 11122;
-- Пересоздаем вьюшку с добавлением ограничения.
create or replace view heavy_orders as
select *
from orders
where freight > 100
with local check option; -- Также можно использовать "with cascade check option".
-- Если прописать таким образом, то ограничение также будет дейвствовать и для подлежащих вьшек.
-- Пробуем снова ввести противоречащие данные. Не получается. Ограничение работа.
insert into heavy_orders (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via,
                          freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country)
values (11123, 'ERNSH', 3, '1998-01-27', '1998-01-27', '1998-01-27', 2, 88, 'Handel', 'Kirchgasse 6', 'Graz',
        'Lara', 8010, 'Austria');

