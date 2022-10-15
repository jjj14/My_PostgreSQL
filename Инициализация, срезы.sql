-- МАССИВЫ
-- Инициализация, срезы
-- Создаем таблицу chess_game с таблицами moves и final_state которые являются массивами.
-- moves[] - одномерный массив а final_state[][] - многомерный массив.
create table chess_game
(
    white_player text,
    black_player text,
    moves        text[],
    final_state  text[][]
);
-- Вставляем данные в массив с синтаксисом Array ['d4', 'd5' , 'c4', 'c5'].
insert into chess_game
values ('Caruana', 'Nakamura',
        Array ['d4', 'd5' , 'c4', 'c5'],
        Array [['Ra8', 'Qe8', 'x', 'x', 'x', 'x', 'x', 'x'],
            ['a7', 'x', 'x', 'x', 'x', 'x', 'x', 'x'],
            ['Kb5', 'Bc5', 'd5', 'x', 'x', 'x', 'x', 'x']]);
-- Изпользуем срезы.
select moves[2:3]
from chess_game;
select moves[:3]
from chess_game;
select moves[2:]
from chess_game;
-- Выводим информацию о массивах с использованием функции array_dims и array_length
select array_dims(moves), array_length(moves, 1)
from chess_game;
select array_dims(final_state), array_length(moves, 1)
from chess_game;
-- Изменяем данные в moves.
update chess_game
set moves = array ['e4', 'd6', 'd4', 'kf6'];
-- Изменяем данные в moves по индексу элемента 4. Индексы начинаются с 1.
update chess_game
set moves[4] = 'g6';
-- Выводим данные из chess_game где в moves имеется "g6".
select *
from chess_game
where 'g6' = any (moves);