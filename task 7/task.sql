create table customers (
    customer_id int primary key,
    name varchar(100),
    city varchar(100)
);
insert into customers (customer_id, name, city) values
(1, 'alice johnson', 'almaty'),
(2, 'brian smith', 'astana'),
(3, 'charlie brown', 'shymkent'),
(4, 'diana adams', 'almaty'),
(5, 'ethan lee', 'karaganda');

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);
insert into orders (order_id, customer_id, order_date, total_amount) values
(101, 1, '2023-05-12', 1500.00),
(102, 1, '2024-01-20', 2200.00),
(103, 2, '2024-03-15', 350.00),
(104, 3, '2023-11-30', 1800.00),
(105, 4, '2024-06-05', 5000.00),
(106, 5, '2024-02-10', 2700.00);

create table products (
    product_id int primary key,
    product_name varchar(100),
    category varchar(50),
    price decimal(10,2)
);
insert into products (product_id, product_name, category, price) values
(201, 'laptop pro 15', 'electronics', 1200.00),
(202, 'wireless mouse', 'accessories', 25.00),
(203, 'desk chair', 'office', 150.00),
(204, 'book: sql basics', 'books', 40.00),
(205, 'graphic tablet', 'electronics', 300.00),
(206, 'notebook a5', 'office', 5.00),
(207, 'usb-c hub', 'accessories', 50.00),
(208, 'antivirus pro', 'software', 80.00);

create table orderdetails (
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);
insert into orderdetails (order_id, product_id, quantity) values
(101, 201, 1),
(101, 202, 2),
(102, 204, 3),
(103, 206, 5),
(104, 205, 1),
(104, 207, 2),
(105, 203, 2),
(106, 208, 4),
(106, 202, 1);


select * from products
where price < 100 and product_name like '%a';

select * from orders
where order_date > '2023-12-31' and total_amount between 2000 and 5000;

select * from customers
where customer_id not in (
  select customer_id
  from orders
  );

select * from customers 
where customer_id in (
  select customer_id from orders
  where total_amount in (
    select total_amount from orders
    where customer_id = 5
  )
);

select * from products
where price > all (
  select price from products
  where category = 'software'
);

select p.product_name, sum(od.quantity) sum
from orderdetails od
join products p on od.product_id = p.product_id
group by p.product_name;

select distinct c.name, p.category
from customers c
join orders o on c.customer_id = o.customer_id
join orderdetails od on o.order_id = od.order_id
join products p on od.product_id = p.product_id;

select c.name, sum(od.quantity) sum
from customers c
join orders o on c.customer_id = o.customer_id
join orderdetails od on o.order_id = od.order_id
group by c.name;

select o.order_id, o.order_date, c.name, p.product_name, od.quantity
from orders o
join customers c on o.customer_id = c.customer_id
join orderdetails od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
order by o.order_date;