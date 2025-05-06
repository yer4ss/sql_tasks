create table Products (
  product_id int primary key,
  name varchar(100),
  category varchar(100),
  price int
);

INSERT INTO Products (product_id, name, category, price) VALUES
(1, 'Keyboard', 'Peripherals', 400),
(2, 'Mouse', 'Peripherals', 300),
(3, 'Monitor', 'Display', 12000),
(4, 'Mousepad', 'Accessories', 250),
(5, 'Webcam', 'Accessories', 3500);

select * from customers 
where age > 20;

select * from customers 
where last_name like '%e';

select * from orders 
where amount between 300 and 1000;

select * from orders 
where item like 'm%';

select * from customers 
where country in ('usa', 'uk');

select * from orders 
where item <> 'keyboard';

select * from products 
order by price desc;

select * from products 
where category in ('accessories', 'peripherals');

select * from shippings 
where status <> 'delivered';

select * from orders 
where amount > 500;

select * from customers 
where customer_id in (select customer_id from shippings);

