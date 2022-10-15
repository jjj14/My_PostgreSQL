-- Update, delete, returning
-- Меняем данные в таблице author.
update author
set full_name = 'Elis',
    rating    = 5
where author_id = 1;
-- Удаляем данные из таблицы author, где author_id 1,2 и 4.
delete
from author
where author_id in (1, 2, 4);
-- Удалает все строки из таблицы author.
delete
from author;
-- Проверяем результаты.
select *
from author;
-- Работает так же как и delete from, но не оставляет логи на сервере об удалении данных.
truncate table author;
--
drop table book;
create table book
(
    book_id      serial,
    title        text        not null,
    isbn         varchar(32) not null,
    publisher_id int         not null,

    constraint PK_book_book_id primary key (book_id)
);
-- returning возвращает измененные данные по указанным столбцам. Данный пример вернул изменение по book_id.
insert into book (title, isbn, publisher_id)
values ('title', '124356', 3)
returning book_id;
-- Данный пример возвращает все изменения.
update book
set title = 'Walter',
    isbn    = '55555'
where book_id = 1
returning *;
-- Данный пример возвращает все удаленные таблицы.
delete from book
returning *;

