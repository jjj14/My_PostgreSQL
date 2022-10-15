-- 1. Автоматизировать логирование времени последнего изменения в таблице products.
-- Добавить в products соответствующую колонку и реализовать построчный триггер.
alter table products
    add column last_update timestamp;

create or replace function track_changes_products() returns trigger as
$$
begin
    new.last_update = now();
    return new;
end;
$$ language plpgsql;

drop trigger if exists products_timestamp on customers;
create trigger products_timestamp
    before insert or update
    on products
    for each row
execute procedure track_changes_products();

select *
from products
order by product_id desc;

update products
set product_name = 'Updatee'
where product_id = 85;

insert into products
values (86, 'Russian', 12, 2, 13, 11, 10, 1, 11, 12);
-- 2. Автоматизировать аудит операций в таблице order_details.
-- Создайте отдельную таблицу для аудита, добавьте туда колонки для хранения наименования операций,
-- имени пользователя и временного штампа. Реализуйте триггеры на утверждения.
select *
from order_details;
drop table if exists order_details_audit;
create table order_details_audit
(
    op           char(2)   not null,
    user_changed text      not null,
    time_stamp   timestamp not null,

    order_id     smallint  not null,
    product_id   smallint  not null,
    unit_price   real      not null,
    quantity     smallint  not null,
    discount     real      not null
);

create or replace function build_order_details_audit() returns trigger as
$$
begin
    if tg_op = 'INSERT' then
        insert into order_details_audit
        select 'I', "session_user"(), now(), nt.*
        from new_table nt;
    elseif tg_op = 'UPDATE' then
        insert into order_details_audit
        select 'U', "session_user"(), now(), nt.*
        from new_table nt;
    elseif tg_op = 'DELETE' then
        insert into order_details_audit
        select 'D', "session_user"(), now(), ot.* from old_table ot;
    end if;
    return null;
end;
$$ language plpgsql;

drop trigger if exists order_details_insert on order_details;
create trigger order_details_insert
    after insert
    on order_details
    referencing new table as new_table
    for each statement
execute procedure build_order_details_audit();

drop trigger if exists order_details_update on order_details;
create trigger order_details_update
    after update
    on order_details
    referencing new table as new_table
    for each statement
execute procedure build_order_details_audit();

drop trigger if exists order_details_delete on order_details;
create trigger order_details_delete
    after delete
    on order_details
    referencing old table as old_table
    for each statement
execute procedure build_order_details_audit();

insert into order_details(order_id, product_id, unit_price, quantity, discount)
values (11078, 3, 111, 22, 0.1);

update order_details
set product_id = 666
where order_id = 11078;

select * from order_details
order by order_id desc;

delete from order_details
where order_id = 11078;

select * from order_details_audit;