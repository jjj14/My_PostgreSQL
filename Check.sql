-- Логическое ограничение check.
drop table if exists book;

create table book (
    book_id int,
    title text not null,
    isbn varchar(32) not null,
    publisher_id int,

    constraint pk_book_book_id primary key (book_id),
    constraint fk_books_publisher foreign key(publisher_id) references publisher(publisher_id)
);
-- Добавляем еще один столбец price и накладываем на него ограничение
-- CHK_book_price check которое говорит что данные вводимые
-- в столбец price было равны или больше 0.
alter table book
add column price decimal constraint CHK_book_price check (price >= 0);
-- Добавляем неправильный данные которые не согласуются с ограничением и получаем ошибку.
insert into book
values (1, 'title', '123456', 1, -1.5);
-- Добавляем правильные данные где price больше 0, и данные вставляются правлиьно.
insert into book
values (1, 'title', '123456', 1, 1.5);
-- Проверяем таблицу. Готово!
select * from book;



