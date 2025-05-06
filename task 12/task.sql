CREATE TABLE Students (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100)
);
go
  
CREATE TABLE DeletedStudents (
    Id INT,
    Name NVARCHAR(100),
    DeletedAt DATETIME
);
go
  
INSERT INTO Students (Name)
VALUES ('nur'), ('ala');
go

create trigger trigg on students
after delete
as
begin
    insert into DeletedStudents (id, name, deletedat)
    select id, name, getdate()
    from deleted;
end;
go

delete from students where name = 'nur';
go


select * from DeletedStudents;