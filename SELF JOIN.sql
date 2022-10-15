--Self join
--Создаем новую таблицу employee.
drop table if exists employee;
create table employee
(
    employee_id int primary key,
    first_name  varchar(255) not null,
    last_name   varchar(255) not null,
    manager_id  int,
    foreign key (manager_id) references employee (employee_id)
);
-- Вставляем данные в таблицу.
insert into employee (employee_id, first_name, last_name, manager_id)
values (1, 'Windy', 'Hays', null),
       (2, 'Ava', 'Chirs', 1),
       (3, 'Hassan', 'Conner', 1),
       (4, 'Anna', 'Reeves', 2),
       (5, 'Sau', 'Norman', 2),
       (6, 'Kelsie', 'Hays', 3),
       (7, 'Tory', 'Goff', 3),
       (8, 'Salley', 'lester', 3);

-- Выводим данные с сотрудников и их менеждеров создавая соединение таблицу саму к себе.
select e.first_name || ' ' ||  e.last_name as employee,
       m.first_name || ' ' || m.last_name as manager
from employee e
left join employee m on m.employee_id = e.manager_id
order by manager;


