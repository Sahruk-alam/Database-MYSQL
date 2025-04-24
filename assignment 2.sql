create database cse;
use cse;
create table teacher(
tid int primary key,
firstName varchar(15),
lastName varchar(15),
dept varchar(10),
age int,
salary float,
);
insert into teacher
values
(1,'Mizanur','Rahman','CSE',28,35000),
(2,'Delwar','Hossain','CSE',26,33000),
(3,'Shafiul','Islam','EEE',24,30000),
(4,'Faisal','Imran','CSE',30,50000),
(5,'Ahsan','Habib','English',28,28000);

drop table teacher

create table employee(
deptid int ,
deptName varchar(10),
location varchar(10)
);
insert into employee values
(1,'CSE','Talaimari'),
(2,'EEE','Talaimari'),
(3,'English','Kazla'),
(4,'BBA','Talaimari');
select * from teacher;
---1
update teacher set salary=salary+(salary*
case
   when dept ='CSE' then 0.15
   when dept ! ='CSE' then 0.10
   else 0
   end
   );
----2
select * into newTable from teacher where tid in 
(select tid from teacher) 

select * from newTable
---3
select  firstName +space(2)+lastName as fullname ,
age from teacher 
where salary=(select max(salary) from teacher)
--4
select firstName ,age ,dept from teacher
where age between 23 and 27
---5
select tid,firstName from teacher where
salary <(select avg(salary) from teacher)
--6
delete from teacher where age in
(select age from teacher where age>25)
---7
update teacher set dept ='ECE' where dept in
(select dept from teacher where dept='english')
---8
update teacher set salary=salary*100
where salary in (select salary from teacher
where salary>5000)
---9
select firstName from teacher where 
firstName in (select firstName from teacher 
where firstName like 's%' or firstName like 'k%');
---10
select firstName,salary from teacher where
dept='CSE' and salary>(select salary from teacher
where firstName='Delwar')
--11
select tid,firstName from teacher where dept=(
select dept from teacher where dept='cse'and
firstName='Delwar' and age =26)

--14
select teacher.tid,teacher.firstName,employee.deptid
from teacher join employee on 
teacher.tid=employee.deptid
where salary>(select avg(salary) from teacher )
---15
select dept ,min(salary) from teacher
group by dept having
min(salary)<(select avg(salary) from teacher)

---16
select teacher.firstName,teacher.lastName,
teacher.dept from teacher join employee on
teacher.tid=employee.deptid where teacher.tid in 
(select employee.deptid from employee
where employee.location='kazla')
---17
select tid,firstName,salary from teacher 
where len(firstName) in (select len(firstName)
from teacher where len(firstName)>6)

