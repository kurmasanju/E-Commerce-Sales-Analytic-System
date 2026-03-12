#creating tables

create table customers(
	customer_id serial primary key,
	customer_name varchar(30),
	email varchar(40),
	city varchar(30),
	join_date date
);

create table categories(
	category_id serial primary key,
	category_name varchar(30)
);

create table product(
	product_id serial primary key,
	product_name varchar(30),
	category_id int references categories(category_id),
	price numeric(10,2),
	stock int
);

create table orders(
	order_id serial primary key,
	customer_id int references customers(customer_id),
	order_date date,
	total_amount numeric(10,2),
	order_status varchar(20)
);

create table order_items(
	order_item_id serial primary key,
	order_id int references orders(order_id),
	product_id int references product(product_id),
	quantity int,
	price numeric(10,2)
);

create table payments(
	 payments_id serial primary key,
	 order_id int references orders(order_id),
	 payment_date date,
	 payment_method varchar(20),
	 payment_status varchar(20)
);

#insert data into tables

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances');

INSERT INTO customers (customer_name,email,city,join_date) VALUES
('Rahul Sharma','rahul@gmail.com','Hyderabad','2024-01-10'),
('Anita Singh','anita@gmail.com','Delhi','2024-02-15'),
('Ravi Kumar','ravi@gmail.com','Bangalore','2024-03-20');


INSERT INTO product (product_name,category_id,price,stock) VALUES
('Laptop',1,65000,20),
('Smartphone',1,30000,50),
('T-shirt',2,800,100),
('Microwave',4,9000,30),
('Python Book',3,500,200);

INSERT INTO orders (customer_id, order_date, total_amount, order_status)
VALUES
(1,'2025-01-10',65000,'Delivered'),
(2,'2025-01-11',800,'Delivered'),
(3,'2025-01-12',30000,'Pending'),
(1,'2025-01-13',5000,'Cancelled'),
(2,'2025-01-14',1200,'Cancelled');

INSERT INTO payments (order_id, payment_date, payment_method, payment_status) VALUES
(1,'2025-01-10','Credit Card','Completed'),
(2,'2025-01-11','UPI','Completed'),
(3,'2025-01-12','Debit Card','Pending'),
(4,'2025-01-13','UPI','Completed'),
(5,'2025-01-14','Net Banking','Completed');


INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1,1,1,65000),
(2,3,2,800),
(3,2,1,30000),
(4,5,3,500),
(5,4,2,9000);

INSERT INTO customers (customer_name, email, city, join_date) VALUES
('Arjun Reddy','arjun@gmail.com','Hyderabad','2024-04-10'),
('Priya Sharma','priya@gmail.com','Mumbai','2024-05-15'),
('Kiran Kumar','kiran@gmail.com','Bangalore','2024-06-20'),
('Sneha Patel','sneha@gmail.com','Ahmedabad','2024-07-12'),
('Rahul Verma','rahulv@gmail.com','Delhi','2024-08-05');

select * from customers;

select * from orders;

select * from product;

select * from order_items;

select * from payments;

select * from categories;



#Analytic Queries
1.total sales
select sum(total_amount) as total_sales from orders;

2.top selling product
select p.product_name,sum(oi.quantity) as total_sold 
from order_items oi
join product p on oi.product_id=p.product_id
group by p.product_name
order by total_sold desc;

3.sales by category
select c.category_name,sum(oi.quantity*oi.price) as sales
from order_items oi
join product p on oi.product_id=p.product_id
join categories c on p.category_id = c.category_id
group by c.category_name;

4.top customer
select c.customer_name,sum(o.total_amount) as total_spent
from orders o
join customers c  on o.customer_id=c.customer_id
group by c.customer_name
order by total_spent desc;

5.montly revenue
select date_trunc('month',order_date) as month,
SUM(total_amount) as revenue
from orders
group by month
order by month;









