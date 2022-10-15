-- Перечисления
-- Создаем перечисление chess_title.
create type chess_title as enum
('Candidate Master', 'FIDE Master', 'International Master');
-- Выводим данные из перчисления.
select enum_range(null::chess_title);
-- Вставляем данные в перечисление.
alter type chess_title
add value 'Grand Master' after 'International Master';
-- Создаем таблицу chess_player.
create table chess_player (
    player_id serial primary key,
    first_name text,
    last_name text,
    title chess_title
);
-- Вставляем данные в столбцы. Вставляем в title 'Grand Master' которое есть в перечислении.
insert into chess_player(first_name, last_name, title)
values ('Magnus', 'Carlsen', 'Grand Master');
-- Вставляем данные которых нет в перечислении.
insert into chess_player(first_name, last_name, title)
values ('Magnus', 'Carlsen', 'Master Master');
--
select * from chess_player;