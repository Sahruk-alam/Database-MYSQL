create database company
use company 
CREATE TABLE Tbl_Management (
    Mgt_id VARCHAR(10) PRIMARY KEY,
    Mgt_Name VARCHAR(50),
    Joining_date DATE,
    Salary INT,
    Position VARCHAR(50)
);

INSERT INTO Tbl_Management VALUES 
('M2015', 'Keshob', '2001-01-18', 250000, 'Managing Director'),
('M2016', 'Rana',   '2003-01-30', 180000, 'Secretary'),
('M2017', 'Jasim',  '2004-04-12', 150000, 'Join secretary'),
('M2018', 'Rajon',  '2004-06-18', 140000, 'Join secretary');

CREATE TABLE Tbl_Emp (
    Emp_id VARCHAR(10) PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Joining_Date DATE,
    Salary INT,
    Division VARCHAR(50)
);

INSERT INTO Tbl_Emp VALUES 
('E1001', 'Suman',  '2003-04-25', 92000, 'Software'),
('E1002', 'Rasel',  '2004-03-13', 86000, 'Network'),
('E1003', 'Hossain','2004-06-21', 82000, 'Software'),
('E1004', 'Polash', '2005-05-05',  9800, 'Network');

CREATE TABLE Tbl_Project (
    P_id VARCHAR(10),
    P_Name VARCHAR(100),
    Mgt_id VARCHAR(10),
    E_id VARCHAR(10),
    P_Cost INT,
    Delivery_date DATE,  
);

INSERT INTO Tbl_Project VALUES 
('P3001','Office Automation','M2016','E1001',2050000, '2016-05-08'),
('P3002','Repair Hub', 'M2016','E1004', 1200000,'2017-06-14'),
('P3003','Server Installation','M2018','E1001',1500500,'2018-02-13'),
('P3004','Network setup','M2017','E1002',2505000,'2018-03-12');

----1
create function fndetails()
returns table
as return(
select p.p_Name,p.p_cost, dense_rank() over (order by p.p_cost asc) as rank,
e.Emp_name from Tbl_Project p join Tbl_Emp e on
p.E_id=e.Emp_id )

select * from dbo.fndetails() order by p_cost
----2
create function UDF(
@project_name varchar (30),
@employee_name varchar (30)
)
returns @result table(
p_Name varchar(20),
p_cost int,
Emp_name varchar(20)
)
as begin
insert into @result
select p.p_Name,p.p_cost, e.Emp_name from Tbl_Project p 
join Tbl_Emp e on p.E_id=e.Emp_id where p.P_Name=@project_name and
e.Emp_Name=@employee_name order by p_cost asc ;
return
end;
select * from dbo.UDF('Network setup','Rasel')
drop function UDF
---3
create function fnrankofmanagement()
returns table as
return(select position ,DENSE_RANK() over(order by joining_date asc)
as rank from Tbl_Management);
select * from dbo.fnrankofmanagement()

---4
create function fnHighSalary(@salarys decimal(10,2))
returns decimal(10,2)
as begin
declare @maxSalary decimal(10,0)
declare @result float
select @maxSalary= max(salary) from Tbl_management
set @result=@maxSalary*1.10
return @result
end;
select dbo.fnHighSalary('salary')

---5
create function fnMaximum()
returns varchar(20)
as begin
declare @projecName varchar(20)
select top 1 @projecName=P_Name from Tbl_Project 
order by P_Cost desc
return @projecName
end;
select dbo.fnMaximum()

---6
create function fnInline(
@cost decimal(10,2),
@cost1 decimal(10,2)
)
returns table
as 
return(select  P_Name,P_cost from Tbl_Project where
P_Cost between @cost and @cost1);
select * from fnInline (1200000,2050000)

---7
create function fnEmployee(@P_id varchar(10), @Mgt_id varchar(10), 
@Emp_id varchar(10))
returns table
as return
(select m.Mgt_id, m.Mgt_Name, e.Emp_Name, m.Joining_Date, 
m.Salary, p.p_name, p.p_cost, p.delivery_date
from Tbl_Management m join
Tbl_Project p on m.Mgt_id=p.Mgt_id join Tbl_Emp e on
e.Emp_id=p.E_id where @P_id=p.P_id and @Mgt_id=m.Mgt_id and 
@Emp_id= e.Emp_id);
select * from fnEmployee('P3001','M2016','E1001')

drop function fnEmployee