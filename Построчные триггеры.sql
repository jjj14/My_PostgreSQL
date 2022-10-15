-- Триггеры.
-- Добавляем в таблицу customers новый столбец last_updated с типом timestamp.
alter table customers
    add column last_updated timestamp;
-- Создаем функцию track_changes_customers которая возвращает таймштамп и встаяет в last_updated.
create or replace function track_changes_customers() returns trigger as
$$
begin
    new.last_updated = now();
    return new;
end;
$$ language plpgsql;
-- Создаем триггер customers_timestamp который перед операциями insert или update вставляет данные
-- в столбец last_updated в таблице customers с помощью функции track_changes_customers
drop trigger if exists customers_timestamp on customers;
create trigger customers_timestamp
    before insert or update
    on customers
    for each row
execute procedure track_changes_customers();
-- Пробуем изменить данные в таблице customers.
update customers
set address = 'bla'
where customer_id = 'ALFKI';
-- Пробуем вставить данные в таблице customers.
insert into customers
values ('ABCDe', 'company', 'contact', 'title', 'address', 'city', null, 'code', 'country', '', '', null);
-- Смотрим вставились ли значения в столбец last_updated. Все верно.
select *
from customers
where customer_id = 'ABCDe';
--
-- Добавляем в таблицу employees столбец employees с типом text.
alter table employees
    add column user_changed text;

-- Создаем функцию track_changes_on_employees которая вставляет в столбец user_changed данные
-- из функции session_user.
create or replace function track_changes_on_employees() returns trigger as
$$
begin
    new.user_changed = "session_user"();
    return new;
end ;
$$ language plpgsql;
-- Создаем триггер employees_user_changed который перед операциями insert или update вставляет данные
-- в столбец user_changed в таблице employees с помощью функции track_changes_on_employees.
drop trigger if exists employees_user_changed on employees;
create trigger employees_user_changed
    before insert or update
    on employees
    for each row
execute procedure track_changes_on_employees();
-- Изменяем данные в таблице employees.
update employees
set salary = 111
where employee_id = 1;
-- Всталяем данные в таблицу employees.
insert into employees
values (10, '', '', '', '', null, null, '', '', '', '', '', '', null, '', '', null, '', null, null)
-- Проверяем вставились ли данные при помощью тригера. Все верно.
select *
from employees;