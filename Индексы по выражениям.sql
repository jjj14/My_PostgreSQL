-- Индексы по выражениям
-- Проверяем каким образом выводятся данные.
explain
select * from perf_test
where annotation like 'AB%';
-- Создаем индексы для колонки annotation в таблице perf_test.
create index idx_perf_test_annotation on perf_test(annotation);
-- Пробуем вывести данные добвив выражение lower. Убеждаемся что индексация при добавленни выражения не работает.
explain select * from perf_test
where lower(annotation) like 'ab%';
-- Добавляем индексы для выражения lower(annotation) по таблице perf_test. Теперь выборка происходит быстрее.
create index idx_perf_test_annotation_lower on perf_test(lower(annotation));