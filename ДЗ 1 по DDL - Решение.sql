-- 1. Создать таблицу teacher с полями teacher_id serial,
-- first_name varchar, last_name varchar, birthday date, phone varchar, title varchar
create table teacher
(
    teacher_id serial,
    first_name varchar,
    last_name  varchar,
    birthday   date,
    phone      varchar,
    title      varchar
);
-- 2. Добавить в таблицу после создания колонку middle_name varchar
alter table teacher
    add column middle_name varchar;
-- 3. Удалить колонку middle_name
alter table teacher
    drop column middle_name;
-- 4. Переименовать колонку birthday в birth_date
alter table teacher
    rename birthday to birth_date;
-- 5. Изменить тип данных колонки phone на varchar(32)
alter table teacher
    alter column phone set data type varchar(32);
-- 6. Создать таблицу exam с полями exam_id serial, exam_name varchar(256), exam_date date
create table exam
(
    exam_id   serial,
    exam_name varchar(256),
    exam_date date
);
-- 7. Вставить три любых записи с автогенерацией идентификатора
insert into exam (exam_name, exam_date)
values ('Exam 1', '1999-01-01'),
       ('Exam 2', '1999-02-02'),
       ('Exam 3', '1999-03-03');
-- 8. Посредством полной выборки убедиться, что данные были
-- вставлены нормально и идентификаторы были сгенерированы с инкрементом
select * from exam;
-- 9. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
truncate table exam restart identity;