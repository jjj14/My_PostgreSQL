-- Построение простого индекса и индекса по двум колонкам
-- Создаем таблицу perf_test.
create table perf_test (
    id int,
    reason text collate "C",
    annotation text collate "C"
);
-- Вставляем рандомные значения в талицу perf_test.
insert into perf_test(id, reason, annotation)
select s.id, md5(random()::text), null
from generate_series(1, 10000000) as s(id)
order by random();
-- Вставляем рандомные значения в столбец annotation в таблице perf_test
update perf_test
set annotation = upper(md5(random()::text));
-- Выводим данные.
select * from perf_test
limit 10;
-- Смотрим каким образом выводятся данные.
explain
select * from perf_test
where id = 3700000;
-- Создаем индексы по указанному столбцу.
create index idx_perf_test_id on perf_test(id);
-- Смотрим каким образом выводятся данные.
explain analyse
select *
from perf_test
where reason like 'bc%' and annotation like 'AB%';
-- Создаем индексы для reason, annotation. Создаем индексы по двум колонкам.
-- При создании индексов по двум колонкам также создаются индексты для первой указанной колонки.
create index idx_perf_test_reason_annotation on perf_test(reason, annotation);
-- Создаем индексы для колонки annotation.
create index idx_perf_test_annotation on perf_test(annotation);
-- Проверяем скорость вывода данных. Все прошло успешно.
select *
from perf_test where reason like '%abc%';
--
select * from perf_test
where annotation like 'ABC%';