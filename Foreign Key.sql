-- Работа с ограничением foreign key.
-- Создаем таблицу pulisher. Добавляем ей ограничение первичного ключа
-- pk_publisher_publisher_id по столбцу publisher_id.
create table pulisher
(
    publisher_id    int,
    publisheer_name varchar(128) not null,
    addresss        text,

    constraint pk_publisher_publisher_id primary key (publisher_id)
);
-- Создаем таблицу book. Добавляем ей ограничение первичного ключа
-- pk_book_book_id по столбцу book_id и ограничение внешнего ключа fk_books_publisher по столбцу publisher_id.
create table book
(
    book_id      int,
    title        text        not null,
    isbn         varchar(32) not null,
    publisher_id int,

    constraint pk_book_book_id primary key (book_id),
    constraint fk_books_publisher
        foreign key (publisher_id)
            references pulisher (publisher_id)
);
-- Вносим данные в таблицу pulisher.
insert into pulisher
values (1, 'Everyman''s Library', 'NY'),
       (2, 'Oxford University Press', 'NY'),
       (3, 'Grand Centra l Publishing', 'Washington'),
       (4, 'Simon & Schuster', 'Chicago');
-- Пробуем внести данные которые идут в разрез с ограничением
-- внешнего ключа по столбцу publisher_id. Выдает ошибку и не дает внести данные в таблицу.
insert into book
values (1, 'The Diary of a Young girl', '0123456345', 10);
-- Если ранее не добавляли добавляем ограничение внешнего ключа
-- fk_books_publisher по столбцу publisher_id.
alter table book
    add constraint fk_books_publisher
        foreign key (publisher_id)
            references pulisher (publisher_id);