-- Рекурсивный CTE.
-- Удалаем таблицу employee если имеется.
drop table if exists employee;
-- Создаем таблицу employee со столбцами employee_id с типом int primary key, first_name, last_name,
-- manager_id где manager_id является foreign key по manager_id.
create table employee
(
    employee_id int primary key,
    first_name  varchar not null,
    last_name   varchar not null,
    manager_id  int,
    foreign key (manager_id) references employee (employee_id)
);
--  Вставляем данные в таблицу employee.
insert into employee (employee_id, first_name, last_name, manager_id)
values (1, 'Windy', 'Hays', null),
       (2, 'Ava', 'Chirs', 1),
       (3, 'Hassan', 'Conner', 1),
       (4, 'Anna', 'Reeves', 2),
       (5, 'Sau', 'Norman', 2),
       (6, 'Kelsie', 'Hays', 3),
       (7, 'Tory', 'Goff', 3),
       (8, 'Salley', 'lester', 3);
-- Выводим данные с помощью оператора конкатенации и left join.
select e.first_name || ' ' || e.last_name as employee,
       m.first_name || ' ' || m.last_name as manager
from employee e
         left join employee m on m.employee_id = e.manager_id
order by manager desc nulls first;
-- Создаем рекурсивную CTE submission при помощью with recursive.
with recursive submission(sub_line, employee_id) as
                   (select last_name, employee_id
                    from employee
                    where manager_id is null
                    union all
                    select sub_line || ' -> ' || e.last_name, e.employee_id
                    from employee e,
                         submission s
                    where e.manager_id = s.employee_id)
select *
from submission;

select *
from employee;