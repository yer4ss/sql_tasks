create database University;

use University;

create table Students (
    id int primary key,
    name varchar(100),
    grade int
);

create procedure AddStudent
    @id int,
    @name varchar(100),
    @grade int
as
begin
    insert into Students (id, name, grade)
    values (@id, @name, @grade);
end;

exec AddStudent @id = 1, @name = 'Era', @grade = 5;