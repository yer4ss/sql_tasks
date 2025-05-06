create table accounts (
    id int primary key,
    owner varchar(100),
    balance int
);
insert into accounts (id, owner, balance) values
(1, 'a', 500),
(2, 'b', 500);

begin;

update accounts set balance = balance - 500 where id = 1;
savepoint first_savepoint;
select * from accounts;

update accounts set balance = balance + 500 where id = 2;
select * from accounts;
savepoint second_savepoint;

rollback to savepoint first_savepoint;
select * from accounts;

commit;