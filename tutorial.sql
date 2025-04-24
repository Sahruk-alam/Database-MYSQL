create database sahruk ;
use sahruk;
create table student (
roll int ,
name varchar(15),
gender varchar(10),
age int,
gpa float,
city varchar(10),
primary key(roll)
);
exec sp_rename 'student',  'student_details'; --table rename
exec sp_rename 'student_details',  'student';
insert into student
--(roll,name,gender,age,gpa,city)
values
(1,'sahruk','male',21,3.78,'rajshahi'),
(2,'sanjoy','male',23,3.88,'rajbari'),
(3,'alice','female',21,3.20,'nator'),
(4,'Manak','male',31,2.78,'sylet'),
(5,'fahim','male',20,3.50,'dhaka');
select avg(gpa) from student;
select name,age from student;

insert into student 
values
(6,'halima','female',22,3.60,'dhaka'),
(7,'Tasnim','male',23,2.50,'rajshahi'),
(8,'kahim','male',20,3.50,'sylet');

select * from student ;

select distinct age,city from student; ---duplicate remove

select TOP 4  * from student;

select * from student order by roll
OFFSET 2 rows fetch NEXT 5 rows only;

select roll ,name from student order by roll desc;

select 5/2.0

select roll,name,age,city from student 
where gender='male' and age<23 order by roll desc;

select roll,name,age,city from student 
where age>21 and (gender='male' or gpa>3.5 );

select roll,name,age,city from student 
where city in ('dhaka' ,'rajshahi','nator') and age>21;

select roll,name,age,city from student 
where roll%2!=0 ;

select roll,name,age,city,gpa from student 
where gpa not in (3.50,3.60,3.20)and gender ='male';

select * from student where name like '%a_';

select roll as ID ,name as 'first name' from student;  --colum name change

create table teacher(
id int not null IDENTITY(101,1),
name varchar(15) not null,
salary float,
primary key(id)
);

insert into teacher
values
('Rafid',409439),
('Hasan',500076),
('Tawhid',293004);

select * from teacher;

update teacher set name='Ripon', salary=2090090
where id=103;

update teacher set name='Nur',salary=480090
where id=102;

select * from teacher;

insert into teacher 
values ('dalim',98200),
('ANU',679200);

select * from teacher;

update teacher set salary=000230 where  name='dalim'; 

select * from teacher;

delete from teacher where id in (113,114) ;

select * from teacher;

select CONCAT(upper(name),' is ', age ,' years old ') 
as student_info from student
where age>21 and gender='male';

select greatest(2,8,3,6); --least ,power

select round (log(2),3);

select rand() as Random ;
select exp(7);

EXEC sp_help 'teacher';

select count(*)as coloum,avg(salary)as Average_salary,--aggregate function
sum(salary) as total,min(salary) as minimum from teacher;

select name,age,gpa from student
where gender='female' and gpa=(select max(gpa) 
from student where gender='female' );

insert into teacher
values
('shafi',80000),
('noyon',75000),
('Rakib',100000),
('Wahab',150000),
('Hridoy',250000);
select * from teacher;

select * from teacher where
salary<(select avg(salary) from teacher);

select name,gpa,age,city from student
where gpa >(select avg(gpa) from student) and gender='male' 
and city='rajshahi' and age<(select avg(age) from student);

alter table teacher add dept varchar(15);

EXEC sp_rename 'teacher.dept', 'department', 'COLUMN';

alter table teacher drop column dept;

update teacher set department='EEE' 
where id=117;

select * from teacher;

select department, sum(salary) from teacher 
group by department order by sum(salary) desc;

select city,sum(gpa) from student  
group by city order by sum(gpa) desc;

SELECT city ,AVG(gpa) FROM student GROUP BY city
having avg(gpa)>(SELECT AVG(gpa) FROM student)
ORDER BY avg(gpa) DESC; 

CREATE TABLE students (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    city VARCHAR(50), 
    age int
);
INSERT INTO students (id, name, city, age) 
VALUES
(1, 'John', 'New York', 38),
(2, 'Alice', 'New York', 37),
(3, 'Bob', 'Los Angeles', 34),
(4, 'Eve', 'Los Angeles', 36),
(5, 'Tom', 'Texas', 31);

UPDATE students SET city = NULL ; --- specific all column null

truncate table students ; --- all column value finish

CREATE TABLE students1 (
    id INT PRIMARY KEY, 
    unit VARCHAR(50) , 
    red_num int , 
    cgpa float
);

drop table students1;

insert into students1 (id,unit,red_num,cgpa)
values
(1,'science',20171,3.57),
(2,'arts',20172,3.67),
(3,'bussiness',20173,3.70),
(4,'science',20174,3.80),
(5,'arts',20175,3.76);

select * from students1;

select students.id ,students.name,students.age,
students1.red_num,
students.city,students1.unit from students join
students1 on students.id = students1.id;

select student.roll,students1.unit,student.gender,
students1.red_num from student left join students1 on 
students1.id=student.roll;

select name,age,city from student
union all 
select name,age,city from students;

create view student_view as select roll,
name,age from student;

select * from student_view ;
update student_view set name='sarjis alam'
where roll=2

insert into student_view
values
(9,'john',19);

delete from student_view where roll=9

select getdate();  ----just date and time
select cast(getdate()as date) --- only date
select DATEADD(day,5,cast(getdate() as date));
select dateadd(year,5,'2025-03-15') as date_time;
select DATEADD(year,-3,dateadd(month,-4,dateadd(day,-2,cast(getdate()as date))))
SELECT dateadd(day,50,DATEFROMPARTS(2025, 4,9));

select format (getdate(),'dddd MMMM dd yyyy');

select format(getdate(),'dddd');

select datename(month,'2009-02-25')

alter table students add Date_of_Birth date;

select * from students

select format(cast(GETDATE()as date),'dddd') ;
select name, format(cast(Date_of_Birth as date),'dddd')
as day from students

select * from students where Date_of_Birth between 
'2003-02-04' and '2009-04-12'

select roll, left(name,3) as first_three_letters from student