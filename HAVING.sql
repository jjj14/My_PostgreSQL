-- Использование having
-- Вывод sum(unit_price * units_in_stock) группированного по category_id где discontinued <> 1 и sum(unit_price * units_in_stock) > 5000 отстортированныый так же по sum(unit_price * units_in_stock) > 5000 по убыванию.
select category_id, sum(unit_price * units_in_stock)
from products
where discontinued <> 1
group by category_id
having sum(unit_price * units_in_stock) > 5000
order by sum(unit_price * units_in_stock) desc;

