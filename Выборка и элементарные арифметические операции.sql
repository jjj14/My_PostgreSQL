select *
from products;
-- Применение мамематической операции к выборкам.
select product_id, product_name, unit_price * units_in_stock as nazvanie_stroki
from products;