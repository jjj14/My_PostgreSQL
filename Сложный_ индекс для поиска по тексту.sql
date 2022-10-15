-- Сложный индекс для поиска по тексту
-- Проверяем каким образом выводятся данные.
explain analyse
select * from perf_test
where reason like '%dff%';
-- Загружает в текущую базу данных новое расширение
create extension pg_trgm;
-- Создаем индекс на базе GIN. Теперь вывод данных с фильтром по типу '%dff%' работает гораздо быстрее.
create index trgm_idx_perf_test_reason on perf_test using gin(reason gin_trgm_ops);