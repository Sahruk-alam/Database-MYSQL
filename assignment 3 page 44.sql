create database product;
use product;
create table salesman (
salesman_id int ,
name varchar(25),
city varchar (10),
commission float,
);
insert into salesman(salesman_id,name,city,commission)
values
(5001, 'James Hoog', 'New York', 0.15), 
(5002,' Nail Knite', 'Paris',  0.13) ,
(5005 ,'Pit Alex' ,'London', 0.11 ),
(5006, 'Mc Lyon', ' Paris', 0.14) ,
(5003 ,'Lauson Hen',null,0.12 ),
(5007, 'Paul Adam',  'Rome', 0.13 );

create table customer(
customer_id int,
cust_name varchar(20),
city varchar(15),
grade int,
salesman_id int 
);
insert into customer
values
(3002, 'Nick Rimando' ,'New York', 100, 5001), 
(3005 ,'Graham Zusi' ,'California' ,200 ,5002 ),
(3001,' Brad Guzan', ' London',null , 5005) ,
(3004, 'Fabian Johns', 'Paris' ,300 ,5006), 
(3007, 'Brad Davis' ,'New York', 200, 5001 ),
(3009 ,'Geoff Camero', 'Berlin' ,100 ,5003 ),
(3008,'Julian Green', 'London', 300, 5002 ),
(3003 ,'Jozy Altidor', 'Moscow' ,200 ,5007 );

create table orders(
ord_no int,
purch_amt float,
ord_date date,
customer_id int,
salesman_id int, 
);
insert into orders
values
(70001, 150.5 ,'2012-10-05', 3005, 5002 ),
(70009, 270.65, '2012-09-10' ,3001,5005) ,
(70002, 65.26, '2012-10-05', 3002, 5001), 
(70004 ,110.5, '2012-08-17', 3009 ,5003) ,
(70007, 948.5 ,'2012-09-10', 3005, 5002 ),
(70005 ,2400.6 ,'2012-07-27', 3007 ,5001) ,
(70008 ,5760, '2012-09-10', 3002 ,5001), 
(70010 ,1983.43 ,'2012-10-10' ,3004 ,5006) ,
(70003 ,2480.4 ,'2012-10-10' ,3009 ,5003) ,
(70012 ,250.45 ,'2012-06-27', 3008 ,5002) ,
(70011, 75.29, '2012-08-17' ,3003 ,5007 ),
(70013 ,3045.6, '2012-04-25', 3002 ,5001);
select * from orders
---1
create view salesman_newyork as
select * from salesman where 
city='new york';
---2
create view salesman_details as
select salesman_id,name,city from salesman
--3
select * from salesman where city='New york' and
commission >.13
---4
create view customer_count as
select grade ,count(*) as total_cust
from customer group by grade
---5
select ord_date ,count(customer_id)as total_customer,
count(salesman_id) total_salesman,
avg(purch_amt) as average_amt,
sum(purch_amt) as total_amt
from orders group by ord_date order by count(*) desc
---6
create view Names as
select salesman.name,customer.cust_name from 
salesman join customer on
salesman.salesman_id = customer.salesman_id
join orders on salesman.salesman_id=orders.salesman_id
---7
create view highest_orders as
select salesman.name,customer.cust_name from 
salesman join customer on
salesman.salesman_id = customer.salesman_id
join orders on salesman.salesman_id=orders.salesman_id
where orders.ord_date in (select top 1 ord_date from orders
group by ord_date order by count(*) desc)
---8
select customer_id from orders group by ord_date
---9
create view highest_grade as
select * from customer where 
grade=(select max(grade) from customer)
---10
select city,count(*) from salesman
group by city 
---11
select distinct salesman.name,count(ord_no) as total ,
cast(count(ord_no)as float) / (select count(distinct ord_no)
from orders ) from salesman
join orders on salesman.salesman_id=orders.salesman_id
group by salesman.name
---12
select distinct salesman.name, count(customer.salesman_id)
from salesman join customer on
salesman.salesman_id=customer.salesman_id
group by salesman.name having count(customer.customer_id)>1
---13
select distinct salesman.salesman_id, salesman.name,salesman.city,
customer.customer_id, customer.cust_name,
customer.city from salesman
join customer on customer.city =salesman.city
---14
create view NumOfOders as
select ord_date,count(*) as numOrders from orders
group by ord_date;
---15
create view salesmanordersdate as
select salesman.name,salesman.city from salesman join orders
on salesman.salesman_id=orders.salesman_id where
orders.ord_date='2012-10-10'
--16
create view salesman_orders_date as
select salesman.name,salesman.city from salesman join orders
on salesman.salesman_id=orders.salesman_id where
orders.ord_date='2012-08-17' or orders.ord_date='2012-10-10';




