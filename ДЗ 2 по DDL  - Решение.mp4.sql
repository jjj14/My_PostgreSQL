-- 1. Создать таблицу exam с полями:
-- - идентификатора экзамена - автоинкрементируемый, уникальный, запрещает NULL;
-- - наименования экзамена
-- - даты экзамена
drop table if exists exam;
create table exam
(
    exam_id   serial unique not null,
    exam_name varchar,
    exam_date date
);
-- 2. Удалить ограничение уникальности с поля идентификатора
alter table exam
drop constraint exam_exam_id_key;
-- 3. Добавить ограничение первичного ключа на поле идентификатора
alter table exam
add constraint PK_exam_exam_id primary key(exam_id);
-- 4. Создать таблицу person с полями
-- - идентификатора личности (простой int, первичный ключ)
-- - имя
-- - фамилия
drop table if exists person;
create table person (
    person_id int primary key,
    name varchar,
    famil varchar
);
-- 5. Создать таблицу паспорта с полями:
-- - идентификатора паспорта (простой int, первичный ключ)
-- - серийный номер (простой int, запрещает NULL)
-- - регистрация
-- - ссылка на идентификатор личности (внешний ключ)
drop table if exists passport;
create table passport (
    passport_id int primary key,
    serial_number int not null ,
    registry varchar,
    person_id int references person(person_id)
);
-- 6. Добавить колонку веса в таблицу book (создавали ранее) с ограничением, проверяющим вес
-- (больше 0 но меньше 100)
alter table book
add column ves float check (ves > 0 and ves < 100);
-- 7. Убедиться в том, что ограничение на вес работает (попробуйте вставить невалидное значение)
insert into book (book_id, title, isbn, publisher_id, ves)
values (1, 'title1', '12435', 1, 103);
-- Валидные значения вставляются.
insert into book (book_id, title, isbn, publisher_id, ves)
values (1, 'title1', '12435', 1, 103);
-- 8. Создать таблицу student с полями:
-- - идентификатора (автоинкремент)
-- - полное имя
-- - курс (по умолчанию 1)
drop table if exists student;
create table student (
    student_id serial,
    full_name varchar,
    course int default 1
);
-- 9. Вставить запись в таблицу студентов и убедиться, что ограничение на вставку значения по умолчанию работает
insert into student(full_name)
values ('Full_name');
-- Все работает.
select * from student;
-- 10. Удалить ограничение "по умолчанию" из таблицы студентов
alter table student
alter column course drop default;
-- 11. Подключиться к БД northwind и добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
select * from products;
alter table products
add constraint check_unit_price check (unit_price > 0);
-- 12. "Навесить" автоинкрементируемый счётчик на поле product_id таблицы products (БД northwind). Счётчик должен начинаться с числа следующего за максимальным значением по этому столбцу.
create sequence if not exists product_product_id_seq
start with 78 owned by products.product_id;

alter table products
alter column product_id set default nextval('product_product_id_seq');
-- 13. Произвести вставку в products (не вставляя идентификатор явно) и убедиться,
-- что автоинкремент работает. Вставку сделать так, чтобы в результате команды вернулось значение,
-- сгенерированное в качестве идентификатора.
insert into products(product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level, discontinued)
values ('Original Frankfurter grüne Soße', 12, 2, 13, 11, 10, 1, 11, 12)
returning product_id;