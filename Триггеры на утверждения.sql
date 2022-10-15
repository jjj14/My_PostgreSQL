-- Триггеры на утвеждения.
drop table if exists products_audit;
-- Создаем таблице products_audit.
create table products_audit
(
    op                char(1)     not null,
    user_changed      text        not null,
    time_stamp        timestamp   not null,

    product_id        smallint    not null,
    product_name      varchar(40) not null,
    supplier_id       smallint,
    category_id       smallint,
    quantity_per_unit varchar(20),
    unit_price        real,
    units_in_stock    smallint,
    units_in_order    smallint,
    reorder_level     smallint,
    discontinued      int         not null,
    last_update timestamp
);
-- Создаем функцию которая вставляем в op "I" если INSERT, "U" если UPDATE и "D" если DELETE.
-- Функция так же всегда вставляет session_user в user_changed при любой их вышеперчисленных операциях.
-- И всегда вставляет таймштамп в time_stamp при любой их вышеперчисленных операциях.
-- А так же при помощую выражения "nt.* from new_table nt" всталяем во все остальные столбцы данные в зависимости
-- от триггера.
create or replace function build_audit_products() returns trigger as
$$
begin
    if tg_op = 'INSERT' then
        insert into products_audit
        select 'I', "session_user"(), now(), nt.*
        from new_table nt;
    elseif TG_OP = 'UPDATE' then
        insert into products_audit
        select 'U', "session_user"(), now(), nt.*
        from new_table nt;
    elseif TG_OP = 'DELETE' then
        insert into products_audit
        select 'D', "session_user"(), now(), ot.*
        from old_table as ot;
    end if;
    return null;
end
$$ language plpgsql;
-- Создаем триггер audit_products_insert по таблице products которая при операции insert встаялет в таблицу
-- products_audit данные при помощую функции build_audit_products.
drop trigger if exists audit_products_insert on products;
create trigger audit_products_insert
    after insert
    on products
    referencing new table as new_table
    for each statement
execute procedure build_audit_products();
-- Создаем триггер audit_products_update по таблице products которая при операции update встаялет в таблицу
-- products_audit данные при помощую функции build_audit_products.
drop trigger if exists audit_products_update on products;
create trigger audit_products_update
    after update
    on products
    referencing new table as new_table
    for each statement
execute procedure build_audit_products();
-- Создаем триггер audit_products_delete по таблице products которая при операции delete встаялет в таблицу
-- products_audit данные при помощую функции build_audit_products.
drop trigger if exists audit_products_delete on products;
create trigger audit_products_delete
    after delete
    on products
    referencing old table as old_table
    for each statement
execute procedure build_audit_products();
-- Вставляем данные в таблицу products.
insert into products
values (85, 'Update', 12, 2, 13, 11, 10, 1, 11, 12);
-- Обновляем/изменяем данные в таблице products.
update products
set product_name = 'Update'
where product_id = 86;
-- Удаляем данные из таблицы products.
delete from products
    where product_id = 86;
-- Проверяем были ли записаны операции в таблице products_audit. Все верно.
select *
from products_audit;