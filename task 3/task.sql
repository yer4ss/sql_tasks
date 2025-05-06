create table Restaurant (
    restaurant_id int primary key,
    name varchar(100),
    location varchar(100)
);


create table Meal (
    meal_id int primary key,
    name varchar(100),
    price decimal(10,2),
    restaurant_id int,
    foreign key (restaurant_id) references Restaurant(restaurant_id)
);


insert into Restaurant (restaurant_id, name, location) 
values 
(1, 'Pizza House', 'New York'),
(2, 'Sushi Bar', 'Tokyo'),
(3, 'Burger King', 'Los Angeles');


insert into Meal (meal_id, name, price, restaurant_id) 
values 
(1, 'Pepperoni Pizza', 12.99, 1),
(2, 'California Roll', 8.50, 2),
(3, 'Cheeseburger', 5.99, 3),
(4, 'Margherita Pizza', 10.99, 1);


select r.name as restaurant, m.name as meal, m.price 
from Restaurant r
join Meal m on r.restaurant_id = m.restaurant_id;


select r.name as restaurant, m.name as meal, m.price 
from Restaurant r
left join Meal m on r.restaurant_id = m.restaurant_id;


select r.name as restaurant, m.name as meal, m.price 
from Restaurant r
right join Meal m on r.restaurant_id = m.restaurant_id;


select r.name as restaurant, m.name as meal, m.price 
from Restaurant r
full join Meal m on r.restaurant_id = m.restaurant_id;



create table Delivery_service (
    service_id int primary key,
    name varchar(100) not null
);


create table Package (
    package_id int primary key,
    description varchar(100) not null,
    delivery_date date not null,
    service_id int,  -- Может быть NULL (если посылка без службы доставки)
    foreign key (service_id) references Delivery_service(service_id)
);


insert into Delivery_service (service_id, name) 
values 
(1, 'United Package Delivery'),
(2, 'Federal Delivery'),
(3, 'Dynamic Duo Delivery');


insert into Package (package_id, description, delivery_date, service_id) 
values 
(1, 'Perfect diamonds', '2012-04-29', 1),
(2, 'Care package', '2012-06-14', 2),
(3, 'French wine', '2012-07-19', null); -- Без службы доставки


insert into Package (package_id, description, delivery_date, service_id) 
values (4, 'Rare painting', '2012-08-15', 99);  -- Ошибка!


select p.package_id, p.description, p.delivery_date, d.name as delivery_service
from Package p
join Delivery_service d on p.service_id = d.service_id;


select d.name as delivery_service, p.description, p.delivery_date
from Delivery_service d
left join Package p on d.service_id = p.service_id;


select p.package_id, p.description, p.delivery_date, d.name as delivery_service
from Package p
left join Delivery_service d on p.service_id = d.service_id
order by d.name;


select d.name as delivery_service, p.description, p.delivery_date
from Delivery_service d
full join Package p on d.service_id = p.service_id
order by p.delivery_date desc;