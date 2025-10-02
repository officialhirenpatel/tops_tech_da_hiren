create database sqlproject;
use sqlproject;


CREATE TABLE Dept (
    Deptno INT(2) NOT NULL DEFAULT 0 primary key,
    Dname VARCHAR(14) DEFAULT NULL,
    Loc VARCHAR(13) DEFAULT NULL
    );


INSERT INTO Dept (Deptno, Dname, Loc)
VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');


CREATE TABLE Emp (
    Empno INT(4) NOT NULL DEFAULT 0 primary key,
    Ename VARCHAR(10) DEFAULT NULL,
    Job VARCHAR(9) DEFAULT NULL,
    Mgr INT(4) DEFAULT NULL,
    Hiredate DATE DEFAULT NULL,
    Sal DECIMAL(7,2) DEFAULT NULL,
    Comm DECIMAL(7,2) DEFAULT NULL,
    Deptno INT(2) DEFAULT NULL,
    foreign key (Deptno) references Dept(Deptno)
    );
    
    
INSERT INTO Emp (Empno, Ename, Job, Mgr, Hiredate, Sal, Comm, Deptno)
VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-06-11', 3000.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-08-09', 1500.00, 0.00, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-07-13', 1100.00, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-03-12', 950.00, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-03-12', 3000.00, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);


CREATE TABLE Student (
    Rno INT(2) NOT NULL DEFAULT 0 primary key,
    Sname VARCHAR(14) DEFAULT NULL,
    City VARCHAR(20) DEFAULT NULL,
    State VARCHAR(20) DEFAULT NULL
    );
    
    
CREATE TABLE Emp_Log (
    Emp_id INT(5) NOT NULL,
    Log_date DATE DEFAULT NULL,
    New_salary INT(10) DEFAULT NULL,
    Action VARCHAR(20) DEFAULT NULL
);


#1. Select unique job from EMP table.

select distinct Job from Emp;


#2. List the details of the emps in asc order of the Dptnos and desc of Jobs?

select
	*
	from Emp
    order by Deptno, Job desc;


#3. Display all the unique job groups in the descending order?

select 
	distinct Job 
	from Emp
	order by Job desc;


#4. List the emps who joined before 1981.

select
	*
    from Emp
    where Hiredate < "1981-01-01";


#5. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal.

select 
	Empno, Ename, Sal as Annual_sal, (Sal)/30 as Daily_sal
    from Emp
    order by Annual_sal;
    
    
#6. List the Empno, Ename, Sal of all emps working for Mgr 7369.

SELECT Empno, Ename, Sal
FROM Emp	
WHERE Mgr = 7369;


#7. Display all the details of the emps who’s Comm. Is more than their Sal?

select * from Emp
	where Sal < Comm ;
    

#8. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.

select * from Emp
	where Job = 'CLERK' or Job ='ANALYST'
    order by Ename desc;


#9. List the emps Who Annual sal ranging from 22000 and 45000.

select * from Emp
	where Sal between 22000/12 and 45000/12;


#10. List the Enames those are starting with ‘S’ and with five characters.

select * from Emp 
	where Ename like 'S____';


#11. List the emps whose Empno not starting with digit78.

select * from Emp
	where Empno not like '78%';


#12. List all the Clerks of Deptno 20.

select * from Emp
	where Job = "ClERK" and Deptno = 20;


#13. List the Emps who are senior to their own MGRS.

select distinct emp.*
	from Emp as emp                                        
	join Emp as mang
	on emp.Empno = mang.Mgr
    where emp.Hiredate < mang.Hiredate;


#14. List the Emps of Deptno 20 who’s Jobs are same as Deptno10.

SELECT *
	FROM Emp
	WHERE Deptno = 20
	AND Job IN (
		SELECT DISTINCT Job
		FROM Emp
		WHERE Deptno = 10
		);


#15. List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.

SELECT *
	FROM Emp
	WHERE Sal in (
		select Sal 
		from Emp 
		where Ename = "SMITH" or Ename = "FORD"
        )
	order by Sal desc;


#16. List the emps whose jobs same as SMITH or ALLEN.

select *
	from Emp
    where Job in (
		select Job 
        from Emp
        where Ename = "SMITH" or Ename = "ALLEN"
        );


#17. Any jobs of deptno 10 those that are not found in deptno 20.

select Job
	from Emp
    where Deptno = 10 and Job not in (
		select Job 
        from Emp
        where Deptno = 20
        );


#18. Find the highest sal of EMP table.

select	max(Sal) from Emp;


#19. Find details of highest paid employee.

select	* from Emp
	where Sal = (select	max(Sal) from Emp);


#20. Find the total sal given to the MGR.

select sum(Sal)
	from Emp
    where Empno in (
		select distinct Mgr from Emp
        );


#21. List the emps whose names contains ‘A’.

select * from Emp
	where Ename like "%A%";
    
    
#22. Find all the emps who earn the minimum Salary for each job wise in ascending order.

select *
	from Emp
    where Sal in (
		select min(Sal) 
        from Emp 
        group by Job
		)
	order by Job;


#23. List the emps whose sal greater than Blake’s sal.

select * 
	from Emp
	where Sal > (
		select Sal 
        from Emp 
        where Ename="BLAKE"
        );
        

#24. Create view v1 to select ename, job, dname, loc whose deptno are same.

create view 
	Que_24 as 
		select e.Ename, e.Job, d.Dname, d.Loc
			from Emp as e
			left join Dept as d
			on e.Deptno = d.Deptno
		;
        
select * from Que_24;


#25. Create a procedure with dno as input parameter to fetch ename and dname.

delimiter //
	create procedure Que_25(in dno int)
	begin
		select e.Ename, d.Dname
			from Emp as e
			left join Dept as d
			on e.Deptno = d.Deptno
            where e.Deptno = dno;
	end //
delimiter ;

call Que_25(20);


#26. Add column Pin with bigint data type in table student.

alter table Student add column Pin bigint; 


#27. Modify the student table to change the sname length from 14 to 40.

alter table Student modify column Sname varchar(40);


#28. Create trigger to insert data in emp_log table whenever any update of sal in EMP table. You can set action as ‘New Salary’.

delimiter $$
	create trigger insert_salary
    before update on Emp
    for each row
	begin
		insert into Emp_log (Emp_id, New_salary) values ((select Empno from Emp where Sal = old.Sal), new.Sal);
	end $$
delimiter ;
