-- Использование group by
-- Вывод данных где количество заказов группировано по ship_country где freight больше 50 отсортированные по количеству заказов.
select ship_country, count(*)
from orders
where freight > 50
group by ship_country
order by count(*);
-- Вывод суммы продуктов группированных по category_id и отсторированных по сумме продуктов по убыванию. Выведено первые 5 строк.
select category_id, sum(units_in_stock)
from products
group by category_id
order by sum(units_in_stock) desc
limit 5;