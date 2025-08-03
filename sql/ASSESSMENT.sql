CREATE DATABASE try;
use try;    

select * from employees;
select * from employee_audit;

CREATE TABLE employees (
	Employee_id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR (100),
	position VARCHAR (100), 
	salary DECIMAL (10, 2), 
	hire_date DATE
	);
    
CREATE TABLE employee_audit (
	audit_id INT AUTO_INCREMENT PRIMARY KEY,
	employee_id INT,
	name VARCHAR(100),
	position VARCHAR (100), 
    salary DECIMAL (10, 2), 
    hire_date DATE,
	action_date TIMESTAMP DEFAULT now()
	);
    
INSERT INTO employees (name, position, salary, hire_date) VALUES 
	('John Doe','Software Engineer', 80000.00, '2022-01-15'),
	('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
	('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');
    
INSERT INTO employees (name, position, salary, hire_date) VALUES 
	('hiren','assistant manager', 50000.00, '2025-05-30');

    delimiter $$
	create trigger employee_audit_trigger
    after insert on employees
    for each row
	begin
			insert into employee_audit (employee_id,name,position,salary,hire_date)
            values (new.employee_id, new.name, new.position , new.salary, new.hire_date);
	end $$
	delimiter ;
    
    
    delimiter $$
	create procedure employees_employee_audit(in a VARCHAR (100), b VARCHAR (100), c DECIMAL (10, 2), d DATE)
	begin
		INSERT INTO employees (name, position, salary, hire_date) VALUES 
			(a,b,c,d);
	end $$
	delimiter ;

	call employees_employee_audit('jay','manager', 45500.00, '2024-11-25');
    
  