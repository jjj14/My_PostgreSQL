-- 1. Создайте функцию, которая делает бэкап таблицы customers (копирует все данные в другую таблицу),
-- предварительно стирая таблицу для бэкапа, если такая уже существует
-- (чтобы в случае многократного запуска таблица для бэкапа перезатиралась).
create or replace function backup_customers() returns void as
$$
drop table if exists backedup_customers;
    create table backedup_customers as
    select *
    from customers;
    -- Другой способ.
    -- select * into backedup_customers
    -- from customers;
    $$ language sql;
-- Проверяем. Все верно.
select backup_customers();
select *
from backedup_customers;
-- 2. Создать функцию, которая возвращает средний фрахт (freight) по всем заказам
create or replace function avg_freight() returns real as
$$
select avg(freight)
from orders;
$$ language sql;
-- Все верно.
select avg_freight();
-- 3. Написать функцию, которая принимает два целочисленных параметра, используемых как нижняя и
-- верхняя границы для генерации случайного числа в пределах этой границы (включая сами граничные значения).
-- Функция random генерирует вещественное число от 0 до 1.
-- Необходимо вычислить разницу между границами и прибавить единицу.
-- На полученное число умножить результат функции random() и прибавить к результату значение нижней границы.
-- Применить функцию floor() к конечному результату, чтобы не "уехать" за границу и получить целое число.
create or replace function get_two_int(low int, high int) returns int as
$$
declare
    result int;
begin
    result = floor((random() * high - low + 1) + low);
    return result;
end;
$$ language plpgsql;
--
select get_two_int(2, 6)
from generate_series(1, 5);
-- 4. Создать функцию, которая возвращает самые низкую и высокую extension среди employees заданного города
create or replace function get_extension_by_city(employee_city varchar, out max_ext int, out min_ext int) as
$$
select max(CAST(extension as int)), min(CAST(extension as int))
from employees
where city = employee_city;
$$ language sql;
-- Проверяем. Работает.
select * from get_extension_by_city('London');
-- 5. Создать функцию, которая корректирует зарплату на заданный процент,
-- но не корректирует зарплату, если её уровень превышает заданный уровень при этом верхний уровень
-- зарплаты по умолчанию равен 70, а процент коррекции равен 15%.
drop table tmp_employees;
create table tmp_employees as select * from employees;
create or replace function get_correct_ext(upper_boundary int default 500, correct_rate real default 0.15) returns void as $$
    update tmp_employees
    set extension = (extension::int + (extension::int * correct_rate))::
    where extension::int <= 500
    $$ language sql;
--
select get_correct_ext();
select * from tmp_employees;
-- 6. Модифицировать функцию, корректирующую зарплату таким образом, чтобы в результате коррекции, она так же выводила бы изменённые записи.
--
-- 7. Модифицировать предыдущую функцию так, чтобы она возвращала только колонки last_name, first_name, title, salary
--
-- 8. Написать функцию, которая принимает метод доставки и возвращает записи из таблицы orders в которых freight меньше значения, определяемого по следующему алгоритму:
--
-- - ищем максимум фрахта (freight) среди заказов по заданному методу доставки
--
-- - корректируем найденный максимум на 30% в сторону понижения
--
-- - вычисляем среднее значение фрахта среди заказов по заданному методому доставки
--
-- - вычисляем среднее значение между средним найденным на предыдущем шаге и скорректированным максимумом
--
-- - возвращаем все заказы в которых значение фрахта меньше найденного на предыдущем шаге среднего
--
-- 9. Написать функцию, которая принимает:
--
-- уровень зарплаты, максимальную зарплату (по умолчанию 80) минимальную зарплату (по умолчанию 30), коээфициет роста зарплаты (по умолчанию 20%)
--
-- Если зарплата выше минимальной, то возвращает false
--
-- Если зарплата ниже минимальной, то увеличивает зарплату на коэффициент роста и проверяет не станет ли зарплата после повышения превышать максимальную.
--
-- Если превысит - возвращает false, в противном случае true.
--
-- Проверить реализацию, передавая следующие параметры
--
-- (где c - уровень з/п, max - макс. уровень з/п, min - минимальный уровень з/п, r - коэффициент):
--
-- c = 40, max = 80, min = 30, r = 0.2 - должна вернуть false
--
-- c = 79, max = 81, min = 80, r = 0.2 - должна вернуть false
--
-- c = 79, max = 95, min = 80, r = 0.2 - должна вернуть true