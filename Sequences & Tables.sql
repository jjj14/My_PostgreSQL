-- Последовательности в связке с таблицами.
-- Удаляем таблицу book если она есть.
drop table if exists book;
-- Создаем таблицу book с добавлением generated always as identity
-- и параметрами start with 10 increment by 2.
-- При добавлении данных book_id будет генерироваться
-- автоматически, начинаться с 10 и инкремент будет 2.
create table book
(
    book_id      int generated always as identity (start with 10 increment by 2) not null ,
    title        text        not null,
    isbn         varchar(32) not null,
    publisher_id int         not null,

    constraint PK_book_book_id primary key (book_id),
    constraint FK_book_publisher foreign key (publisher_id) references publisher (publisher_id)
);
-- Если бы мы использовали int без generated always as identity,
-- то мы могли бы добавить sequence вручкуню прописав параметры для столбца book_id.
create sequence if not exists book_book_id_seq
start with 1 owned by book.book_id;
-- Добавочное ограничение которое нужно для работы sequence с book_id.
alter table book
alter column book_id set default nextval('book_book_id_seq');
-- Можно добавлять данные в таблицу без явного указывания book_id.
-- book_id будет генерироваться с параментрами которые мы указали.
insert into book(title, isbn, publisher_id)
values ('title', '12345', 2);
-- В данный момент при добавлении ограничения generated always as identity нельзя явно вставлять
-- данные в book_id. Данный запрос выведет ошибку.
insert into book(book_id, title, isbn, publisher_id)
values (3, 'title', '12345', 2)
-- Обойти вышеуказанную проблемы можно если добавить параметр overriding system value.
-- Таким образом можно явно вставлять данные в book_id.
insert into book(book_id, title, isbn, publisher_id)
overriding system value
values (3, 'title', '12345', 2);
-- Выводим все таблицы для проверки результатов работы при каждом этапе.
select * from book;



