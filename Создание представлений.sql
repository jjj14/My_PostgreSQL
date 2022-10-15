-- Представления views
-- Создаем вьюшку products_suppliers_categories.
create view products_suppliers_categories as
select product_name,
       quantity_per_unit,
       unit_price,
       units_in_stock,
       company_name,
       contact_name,
       phone,
       category_name,
       description
from products
         join suppliers using (supplier_id)
         join categories using (category_id);
-- Выводим вьюшку с накладыванием фильтра.
select *
from products_suppliers_categories
where unit_price > 20;
-- Удаляем вьюшку.
drop view if exists products_suppliers_categories;