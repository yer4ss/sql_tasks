CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    manager_id INT,
    location_id INT
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(10, 2),
    commission_pct DECIMAL(4, 2),
    manager_id INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments VALUES 
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'IT', 202, 1700),
(40, 'Sales', 203, 1800);

INSERT INTO employees VALUES
(200, 'Karen', 'Hughes', 'KHUGHES', '1234567880', '2020-01-01', 'AD_VP', 15000, NULL, NULL, 10),
(201, 'Steve', 'Miller', 'SMILLER', '1234567881', '2020-01-01', 'MK_MAN', 13000, NULL, 200, 20),
(202, 'Alice', 'Johnson', 'AJOHNSON', '1234567882', '2020-01-01', 'IT_MAN', 14000, NULL, 200, 30),
(203, 'Robert', 'King', 'RKING', '1234567883', '2020-01-01', 'SA_DIR', 16000, NULL, 200, 40);


insert into departments VALUES
(50, NULL, 204, null);
INSERT INTO employees VALUES
(204, NULL, NULL, NULL, NULL, '2020-01-01', NULL, NULL, NULL, NULL, 50);

insert into departments VALUES
(60, 'Security', null, null);

insert into employees (employee_id, first_name, department_id, hire_date)
values (206, 'michael', 30, current_date);

-- 4. вставить строку с датой через to_date
insert into employees values (
    207, 'jane', 'smith', 'jsmith', '1234567891',
    to_date('2024-12-31', 'yyyy-mm-dd'),
    'hr_rep', 4500.00, null, null, 20
);

-- 5. скопировать сотрудников с зарплатой > 7000 в high_salary_emp
create table high_salary_emp as
select * from employees
where salary > 7000;

-- 6. увеличить зарплату на 5% всем, кто работает в отделе 30
update employees
set salary = salary * 1.05
where department_id = 30;

-- 7. обновить работу и зарплату всем, кто подчиняется менеджеру 201
update employees
set job_id = 'sr_dev', salary = salary + 2000
where manager_id = 201;

-- 8. обнулить зарплату тем, кто работает в 'administration'
update employees
set salary = 0
where department_id = (
    select department_id from departments
    where lower(department_name) = 'administration'
);

-- 9. удалить сотрудников, у которых нет department_id
delete from employees
where department_id is null;

-- 10. удалить отдел с department_id = 10
delete from departments
where department_id = 10;

-- 11. удалить всех сотрудников, у кого имя начинается на 'l'
delete from employees
where lower(first_name) like 'l%';

-- 12. удалить всех из high_salary_emp
delete from high_salary_emp;

-- 13. truncate high_salary_emp
truncate table high_salary_emp;

-- 14. использовать savepoint и выполнить откат после update
begin;

savepoint before_update;

update employees
set salary = salary + 1000
where department_id = 40;

rollback to savepoint before_update;

commit;

-- 15. select с for update для всех сотрудников с зарплатой > 6000
select * from employees
where salary > 6000
for update;