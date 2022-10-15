-- Ограничение DEFAULT.
-- Создаем таблицу customer.
-- Добавляем ограничение check с логикой
-- status = 'r' or status = 'p' и status char default 'r'.
create table customer (
    customer_id serial,
    full_name text,
    status char default 'r',

    constraint PK_customer_customer_id primary key(customer_id),
    constraint CHK_customer_status check (status = 'r' or status = 'p')
);
-- Добавляем данные в таблицу customer.
-- Добавляем только full_name потому что customer_id
-- генерируется автоматически потому что тип serial
-- и status имеет default 'r' который автоматом добавляет значением по умолчанию 'r'.
insert into customer(full_name)
values ('full_name');
-- Тем не менее мы можем явно добавлять данные в таблицы.
insert into customer
values (2, 'full_name', 'p');
-- Проверяем и убеждаемся в том что значения были вставлены и сгенерированы правильно.
select * from customer;
-- Данная команда удаляет ограничение default со столбца status в таблице customer.
alter table customer
alter column status drop default;
-- Данная команда добавляет ограничение default со столбца status в таблице customer.
alter table customer
alter column status set default 'r';
