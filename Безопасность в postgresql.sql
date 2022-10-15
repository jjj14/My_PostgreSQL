-- Безопасность в postgresql.
-- Создаем роли sales_stuff и northwind_admins.
create role sales_stuff;
create role northwind_admins;
-- Создаем пользователей john_smith и north_admin_1 с паролем qwerty.
create user john_smith with password 'qwerty';
create user north_admin_1 with password 'qwerty';
-- Отзываем права доступа на схему public.
revoke create on schema public from public;
-- Отзываем права доступа на базу northwind.
revoke all on database northwind from public;

--- Права на уровне БД и схем.

-- Предоставляем права на подключение к базе northwind для sales_stuff и northwind_admins.
grant connect on database northwind to sales_stuff;
grant connect on database northwind to northwind_admins;
-- Даем доступ на схему public для sales_stuff.
grant usage on schema public to sales_stuff;
-- Предоставляем права на схему public для northwind_admins.
grant usage on schema public to northwind_admins;
-- Предоставляем права на создавать новые объекты в схеме public.
grant create on schema public to northwind_admins;
-- Предоставляем права на создавать новые объекты в базе northwind.
grant create on database northwind to northwind_admins;
-- Предоставляем роль sales_stuff для пользователя john_smith.
grant sales_stuff to john_smith;
-- Предоставлям права northwind_admins для пользователя north_admin_1.
grant northwind_admins to north_admin_1;

--- Права на уровне таблиц.

-- Проверяем какие права у каких пользователей есть на таблицу employees.
select grantee, privilege_type
from information_schema.role_table_grants
where table_name = 'employees';
-- Предоставляем права select, insert, update и delete для таблиц
-- public.order_details, public.orders и public.products для роли sales_stuff.
grant select, insert, update, delete on table
    public.order_details,
    public.orders,
    public.products
    to sales_stuff;
-- Предоставляем права select роли sales_stuff по таблице public.employees.
grant select on table public.employees to sales_stuff;
-- Предоставляем права select, update, delete, insert, references, trigger
-- роли northwind_admins на все таблицы в схеме public.
grant select, update, delete, insert, references, trigger on all tables in schema public
    to northwind_admins;

--- Права на уровне колонок

-- Изымаем права на select по таблице employees для роли sales_stuff.
revoke select on employees from sales_stuff;
-- Предоставляем роли sales_stuff права на salect по таблице employees по определенным столбцам.
grant select (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, city, region,
              postal_code, country, home_phone, extension, photo, notes, reports_to, photo_path) on employees
    to sales_stuff;
-- Проверяем количество данных по таблице products.
select * from products;
select count(*) from products;
-- Включаем защиту строк для таблицы products. При попытке select к таблице products выведется пустота.
alter table products
enable row level security;
-- Создаем политику доступа на строки по таблице products.
-- Данная политики дает права роли sales_stuff для select по таблице products где discontinued не равно 1.
-- Т.е. при попытке полной выборки будут выведены только столбцы которые удовлетворяют данному условию.
create policy active_prod_for_sales on products
for select
to sales_stuff
using (discontinued <> 1);
-- Создаем политику где sales_stuff имеет права селектить столбцы которые подпадают
-- под условие reorder_level больше 10.
-- Стоит учитывать что две политики которые были созданы логически противоречат друг другу.
-- При попытке полной выборки будут возвращены все столбцы которые подподают либо под одно либо под другое.
create policy reor_prod_for_sales on products
for select
to sales_stuff
using (reorder_level > 10);
-- Удаляем политику которая противоречит логике.
drop policy reor_prod_for_sales on products;

--- Изымаем все права и удаляем роли.

-- Изымаем права на таблицы order_details, orders, products и employees у роли sales_stuff.
revoke all privileges on order_details, orders, products, employees from sales_stuff;
-- Изымаем права на базу northwind у роли sales_stuff.
revoke all on database northwind from sales_stuff;
-- Изымаем права на схему public у роли sales_stuff.
revoke all on schema public from sales_stuff;
-- Удаляем политики которые создавали для таблицы products.
drop policy if exists reor_prod_for_sales on products;
drop policy if exists active_prod_for_sales on products;
-- Удаляем роль sales_stuff.
drop role sales_stuff;
-- Удалям пользователя john_smith.
drop user john_smith;
-- Команда для просмотра ролей и пользователей.
select * from pg_roles;