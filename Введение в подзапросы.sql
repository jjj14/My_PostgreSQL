-- Подзапросы
-- Вывод названии компании из городов из которых также и сторудники.
select company_name
from suppliers
where country in (select distinct country
                  from customers);
-- Замена подзапроса join.
select distinct s.company_name
from suppliers s
join customers using(country);
-- Вывод category_name, sum(units_in_stock) из таблицы products с объединенем с таблицей categories с использованием category_id
select category_name, sum(units_in_stock)
from products
inner join categories using(category_id)
group by category_name
order by sum(units_in_stock) desc
limit(select min(product_id) + 4 from products);
-- Вывод product_name, units_in_stock где units_in_stock больше чем среднее по units_in_stock.
select product_name, units_in_stock
from products
where units_in_stock > (select avg(units_in_stock)
                        from products)
order by units_in_stock;