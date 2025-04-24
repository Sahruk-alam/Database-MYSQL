create database example;
use example;
create table worker(
worker_id int primary key,
first_name varchar(50),
last_name varchar(30),
salary float,
joinning_date date,
department varchar(15),
);

Insert into worker (worker_id,first_name,last_name,salary,joinning_date,department)
values
(1,'Rana','Hamid',100000,'2014-02-20','HR'),
(2,'sanjoy','SAha',80000,'2014-06-11','Admin'),
(3,'Mahmudul','Hasan',300000,'2014-02-20','HR'),
(4,'Asad','zaman',500000,'2014-02-20','Admin'),
(5,'Sajib','Mia',500000,'2014-06-11','Admin'),
(6,'Alamgir','kabir',200000,'2014-06-11','Account'),
(7,'Faridul','Islam',75000,'2014-01-20','Account'),
(8,'keshob','Ray',90000,'2014-04-11','Admin');

select worker_id,last_name,salary,department
from worker;
select * from worker;
drop table worker;

create table bonus (
worker_ref_id int ,
bonus_date date ,
bonus_amount float
);   

insert into bonus (worker_ref_id, bonus_date,bonus_amount)
values
(1,'2019.02.20',5000),
(2,'2019.06.11',3000),
(3,'2019.02.20',4000),
(4,'2019.02.20',4500),
(5,'2019.02.11',3500),
(6,'2019.06.12',null);

select * from bonus;

create table title (
worker_ref_id int ,
worker_title varchar(20),
affected_from date 
);

INSERT INTO title (worker_ref_id, worker_title, affected_from)
VALUES
(1, 'Manager', '2019-02-20'),
(2, 'Execute', '2019-06-11'),
(8, 'Execute', '2019-06-11'),
(5, 'Manager', '2018-06-11'),
(4, 'Asst. Manager', '2019-06-11'),
(7, 'Executive', '2019-06-11'),
(6, 'Lead', '2019-06-11'),
(3, 'Lead', '2019-06-11');

select * from title;

select worker_ref_id from title;
----1
select left(first_name , 3) as first_three_characters
from worker ;
---2
select * from worker where joinning_date between 
'2014-02-01' and '2014-03-01';
---3
select * from worker where 
datediff(month,joinning_date,getdate())>=60 ;
---4
update worker set salary=salary-20000 from
worker join title on worker.worker_id=title.worker_ref_id
where worker_title ='Manager';
---ex
select worker.worker_id,worker.salary,title.worker_title
from worker join title on worker.worker_id=title.worker_ref_id
where worker_title= 'Manager'

update worker set salary=salary+(salary*0.1) from 
worker where joinning_date < '2014-04-11'
and department='Admin';

update worker set salary=salary+(salary*0.05) from 
worker where joinning_date >= '2014-04-11'
and department='Admin';
---5
update worker set salary=salary+(salary*
case
when joinning_date <'2014-04-11' and department='Admin' then 0.10
when joinning_date>='2014-04-11' and department='Admin' then 0.05
else 0
end
);
---6
delete from worker where department !='Admin';
select * from worker 
where department='Admin' and joinning_date >= '2014-04-11';

delete from worker where salary !=.10 and salary !=.05

delete from worker where not exists (select 1 from bonus
where worker.worker_id=bonus.worker_ref_id);
--7
select * from worker where first_name in('Rana','sajib') 
--8
select * from worker where first_name not in('Rana','sajib') 
----9
select * from worker where first_name like '%a%'  
---10
select * from worker where first_name like 'k%'  
---11
select * from worker where first_name like '%r' and 
len(first_name)=7
----12
select first_name ,charindex('n', first_name) from worker 
where first_name='sanjoy'
----13
select department , avg(salary) as average from worker 
group by department
----14
select * from worker where salary in (select max(salary)
from worker group by department) or salary in (select min(salary)
from worker group by department)
---15
select charindex('n',first_name) from worker 
where first_name='Rana';
---16
SELECT rtrim(FIRST_NAME) FROM Worker;
---17
select distinct first_name,len(first_name) from worker
---18
select replace(first_name,'a','A') from worker
----others example
select count(*) from worker 

SELECT CHAR(99)  
select 'I am '+ 'student'

SELECT LEFT('SQL Tutorial', 6) 

select len('sahruk')
select substring('sahruk',2,4)
select first_name+space(3)+last_name from worker

Select ISDATE('2012-08-31 21:02:04.167') 
Select year('2012-08-31') 

select format(getdate(),'dddd-dd-MMMM-yyyy');
select getdate() as date

select worker_id,first_name from worker where
joinning_date not between '2014-02-01' and '2014-04-20'

select worker_id,first_name,salary from worker where
(salary between 70000 and 100000) and worker_id
 not in(1,2,4)
SELECT ISNULL('hello', lower('Default Value is hdvfbg')) ;

ALL (select first_name from worker where worker_id=4)

select * from worker where salary> all (select salary from
worker where department='account');

SELECT * FROM Worker  WHERE SALARY > any (SELECT 
SALARY FROM Worker WHERE DEPARTMENT = 'HR');

select * from worker where first_name like 'a%'

select * from worker where exists(select 1 from bonus 
where worker_id=worker_ref_id) ---check subquery true or false

select department from worker
EXCEPT
select worker_title from title
-----38 page 

----1
select * from worker join title 
on worker.worker_id=title.worker_ref_id 
where worker_title not in ('Manager','Asst. Manager');
---2
select * from worker where joinning_date > '2014-04-01' 
order by worker_id asc
----3
select count(*) from worker where department = 'Admin';
--4
select first_name,salary from worker 
where salary >=50000 and salary<=100000;
---5
select department ,count(*) from worker group by department
order by count(*) desc ;
--6
select * from worker join title on 
worker.worker_id=title.worker_ref_id 
where worker_title='Manager'
--7
select * from worker where worker_id%2! =0 ;
---8
select * from worker where worker_id%2 =0 ;
--9
select * into newtable from worker;
--10
select getdate();
--11
select Top 5 worker.first_name ,title.worker_title from worker
join title on worker.worker_id=title.worker_ref_id
---12
select distinct top 1 salary from  (select 
distinct top 5 salary from worker order by 
salary desc ) as work order by salary asc
---13
select first_name,salary from worker where salary 
in (select salary from worker group by salary 
having count(*)>1)
--14
select max(salary) from worker where 
salary<(select max(salary)from worker)
--15
select top 50 percent * from worker order by worker_id
---16
select * from worker where department in(select department,count(*) 
from worker group by department having count(*)<5)
---17
select department,count(*) from worker group by
department 
---18
select top 1 worker_id from worker order by worker_id desc
---19
select top 1 * from worker order by worker_id asc
--20
select top 5 * from worker order by worker_id desc
--21 
select first_name , salary,department from worker
where salary in (select distinct max(salary) from worker 
group by department)
---22
select distinct top 3 salary from worker 
order by salary desc

