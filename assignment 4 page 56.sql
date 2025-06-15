create database bank;
use bank
CREATE TABLE Account_detail (
    Account_no INT PRIMARY KEY,
    Acc_holder_name VARCHAR(100),
    Amount DECIMAL(10, 2),
    Branch_Id VARCHAR(10),
    Zone_Id VARCHAR(10),
);
CREATE TABLE Branch (
    Br_Id VARCHAR(10),
    Branch_Name VARCHAR(100)
);
CREATE TABLE Zone (
    Zone_Id VARCHAR(10),
    Name VARCHAR(100)
);
INSERT INTO Account_detail(Account_no, Acc_holder_name, Amount, Branch_Id, Zone_Id) VALUES 
(1992212, 'Mr. Nazmuzzaman', 200000, 'B-101', 'Z-803'),
(1992213, 'Mr. Jibon', 170000, 'B-102', 'Z-803'),
(1882212, 'Bushra', 180000, 'B-103', 'Z-802'),
(1882213, '%Sajib', 170000, 'B-104', 'Z-801');

INSERT INTO Branch (Br_Id, Branch_Name) VALUES 
('B-101', 'Bonani'),
('B-102', 'Romna'),
('B-103', 'Shaheb bazar'),
('B-104', 'Ullapara');

INSERT INTO Zone (Zone_Id,Name) VALUES 
('Z-801', 'Sirajgonj'),
('Z-802', 'Rajshahi'),
('Z-803', 'Dhaka'),
('Z-804', 'Chittagong');
----1
create procedure SPdetails
as
begin
select Account_detail.Acc_holder_name ,
Account_detail.Amount,branch.Branch_Name,Zone.name
from Account_detail join Branch on
Account_detail.Branch_Id=Branch.Br_id join Zone on
Account_detail.Zone_Id = Zone.Zone_id
end;
EXEC SPdetails

----extra

create procedure SPdetail12
@newAmount float
as
begin
select Account_detail.Acc_holder_name ,
Account_detail.Amount,branch.Branch_Name,Zone.name
from Account_detail join Branch on
Account_detail.Branch_Id=Branch.Br_id join Zone on
Account_detail.Zone_Id = Zone.Zone_id
where Amount>@newAmount
END 
exec SPdetail12 175000 
drop proc SPdetail12

-----extra

create procedure SPdetail123
@newAmount float
with encryption
as
begin
select Account_detail.Acc_holder_name ,
Account_detail.Amount,branch.Branch_Name,Zone.name
from Account_detail join Branch on
Account_detail.Branch_Id=Branch.Br_id join Zone on
Account_detail.Zone_Id = Zone.Zone_id
where Amount>=@newAmount
END 
exec SPdetail123 170000 

----2
create procedure SPaverage
@branch_names varchar(20),
@amounts decimal(10,2)
as 
begin
select b.Branch_Name,a.Amount from
Account_detail a join Branch b on a.Branch_Id=b.Br_Id
where a.Amount>@amounts and b.Branch_Name=@branch_names
end;
exec SPaverage @branch_names='Shaheb bazar' ,@amounts=170000;

----3
create procedure SPbalance
@Zone_name varchar(20)
as 
begin
DECLARE @totalamount int;
select @totalamount =sum(a.Amount) from Account_detail a join Zone z
on a.Zone_Id=z.Zone_Id where z.Name=@Zone_name
return @totalamount ;
end;
declare @amount int;
exec @amount=SPbalance @Zone_name='dhaka';
print @amount

drop proc SPbalance

----4

create procedure SPamount
as begin
select a.Acc_holder_name,b.Branch_Name,z.name from Account_detail a
join Branch b on a.Branch_Id=b.Br_Id join Zone z on 
z.Zone_Id=a.Zone_Id where a.Acc_holder_name like '%Mr.%' and
a.Amount < (select max(Amount) from Account_detail);

end ;
exec SPamount

-----5

create procedure SPdetailsInfo
@zone_name varchar(20),
@customer_count int output
as begin
select @customer_count=count(*) from Account_detail a join Zone z on
a.Zone_id=z.Zone_Id where z.Name=@zone_name
end;

declare @count int;
exec  SPdetailsInfo 'dhaka',@customer_count=@count output
print 'no. of customer : ' +cast(@count as varchar) 

---6

create procedure spEmployeeSalaryDetails
@startamounts float,
@endamount float,
@branch_name varchar(20),
@countamount decimal(10,2) output
as begin
select @countamount=count(distinct b.Branch_Name)
from Account_detail a join Branch b on a.Branch_Id=b.Br_Id
where a.Amount between @startamounts and @endamount
 AND b.Branch_Name LIKE '%' + @branch_name + '%'
and b.Branch_Name like '%Ba%'
end;

declare @findamount int;
exec spEmployeeSalaryDetails @startamounts=7000,@endamount=30000,
@branch_name='Bamna',@countamount=@findamount output
print @findamount

----7

create procedure SPdetailsInfo1
@zonename varchar(20)
as begin
select Zone.Name,count(Account_detail.Account_no) as customer
from Account_detail join Zone on Account_detail.Zone_Id=
Zone.Zone_Id where Zone.Name=@zonename
group by Zone.Name
end;
exec SPdetailsInfo1 'dhaka'

---8

create procedure SPdetailsInfo2
@branch_name varchar(20)
as begin
select z.Name, count(b.Br_Id) from Account_detail a join Zone z
on a.Zone_id=z.Zone_Id join Branch b on b.Br_Id=a.Branch_Id
where b.Branch_Name=@branch_name
group by z.Name
end;

exec SPdetailsInfo2 'ullapara'
