create database MarketCo;
use MarketCo;

select * from company;
select * from contact;
select * from employee;
select * from contactemployee;


create table company(
	companyid int primary key,
    companyname varchar(45),
    street varchar(45),
    city varchar(45),
    state varchar(20),
    zip varchar(10)
    );
    
create table contact(
	contactid int primary key,
    companyid int,
    firstname varchar(45),
    lastname varchar(45),
    street varchar(45),
    city varchar(45),
    state varchar(20),
    zip varchar(10),
    ismain boolean,
    email varchar(45),
    phone varchar(12),
    foreign key (companyid) references company(companyid)
    );
    
create table employee(
	employeeid int primary key,
    firstname varchar(45),
    lastname varchar(45),
    salary decimal(10,2),
    hiredate date,
    jobtitle varchar(25),
    email varchar(45),
    phone varchar(12)
    );
    
create table contactemployee(
	contactemployeeid int,
    contactid int,
    employeeid int,
    contactdate date,
    description varchar(100),
    foreign key (contactid) references contact(contactid),
    foreign key (employeeid) references employee(employeeid)
    );
    
insert into company (companyid,companyname) values (1, 'Urban Outfitters, Inc.', 'mahadev road', 'surat', 'gujarat', '394305'),
													(2, 'way 2 web'),
                                                    (3, 'nextgen pvt ltd');
insert into contact (contactid, companyid, firstname) values (1,1,'Toll Brothers'),
															 (2,2,'sudhir'),
                                                             (3,3,'prabodham');
insert into contactemployee (contactemployeeid, contactid, employeeid) values (1,1,1),
																			  (2,2,2),
                                                                              (3,3,3);
insert into employee (employeeid, firstname) values (1,'Lesley Bland', 'patel', 45000, '2009-04-23', 'dataanalyst', 'abc@gmail.com', '9876543210'),
													(2, 'Dianne Connor'),
                                                    (3, 'Jack Lee');

    
update employee set phone = '215-555-8800' where firstname='Lesley Bland';
	
    
update company set companyname = 'Urban Outfitters' where companyname = 'Urban Outfitters, Inc.';


DELETE FROM contactemployee
	WHERE employeeid in ( 
						(SELECT employeeid 
						FROM employee
						WHERE (firstname='Dianne Connor') )
						,
						(SELECT employeeid 
						FROM employee
						WHERE (firstname='Jack Lee') )
                        );

select
	employee.firstname
    from employee
    left join contactemployee
    on employee.employeeid = contactemployee.employeeid
    left join contact
    on contactemployee.contactid = contact.contactid
    where contact.firstname='Toll Brothers'
    group by employee.firstname;                  # result = 'Lesley Bland'


    
/*
1) Statement to create the Contact table

		create table contact(
		contactid int primary key,
		companyid int,
		firstname varchar(45),
		lastname varchar(45),
		street varchar(45),
		city varchar(45),
		state varchar(20),
		zip varchar(10),
		ismain boolean,
		email varchar(45),
		phone varchar(12),
		foreign key (companyid) references company(companyid)
		);



2) Statement to create the Employee table

		create table employee(
		employeeid int primary key,
		firstname varchar(45),
		lastname varchar(45),
		salary decimal(10,2),
		hiredate date,
		jobtitle varchar(25),
		email varchar(45),
		phone varchar(12)
		);
    
    
    
3) Statement to create the ContactEmployee table
HINT: Use DATE as the datatype for ContactDate. It allows you to store the date in this format: YYYY-MM-DD (i.e., ‘2014-03-12’ for March 12, 2014).

		create table contactemployee(
		contactemployeeid int,
		contactid int,
		employeeid int,
		contactdate date,
		description varchar(100),
		foreign key (contactid) references contact(contactid),
		foreign key (employeeid) references employee(employeeid)
		);



4) In the Employee table, the statement that changes Lesley Bland’s phone number  to 215-555-8800

		update employee set phone = '215-555-8800' where firstname='Lesley Bland';
        
        
        
5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” .

		update company set companyname = 'Urban Outfitters' where companyname = 'Urban Outfitters, Inc.';
        
        
        
6) In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement).
HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove.

		DELETE FROM contactemployee
		WHERE employeeid in ( 
						(SELECT employeeid 
						FROM employee
						WHERE (firstname='Dianne Connor') )
						,
						(SELECT employeeid 
						FROM employee
						WHERE (firstname='Jack Lee') )
                        );



7) Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). 
Run the SQL SELECT query in MySQL Workbench. Copy the results below as well.

		select
		employee.firstname
		from employee
		left join contactemployee
		on employee.employeeid = contactemployee.employeeid
		left join contact
		on contactemployee.contactid = contact.contactid
		where contact.firstname='Toll Brothers'
		group by employee.firstname;



8) What is the significance of “%” and “_” operators in the LIKE statement?

		1. % — Percentage Sign

		Represents zero or more characters.
		It can match any sequence of characters, including an empty string.

		Example - SELECT * FROM employees WHERE name LIKE 'A%'; (“Alice”, “Andrew”, “Amit”, "A")
				- SELECT * FROM employees WHERE name LIKE '%son'; (“Jackson”, “Emerson”, “son”)
				
		2. _ — Underscore sign

		Represents exactly one character.
		Each underscore corresponds to one character.

		Example - SELECT * FROM employees WHERE name LIKE '_im'; (“Jim”, “Tim”, “Kim”)
				- SELECT * FROM employees WHERE name LIKE 'A__'; (“Amy”, “Abe”, “Ann”)



9) Explain normalization in the context of databases.

		Normalization is a process in database design used to organize data efficiently by reducing redundancy (duplicate data) 
		and ensuring data integrity. 
		It involves dividing a large table into smaller, related tables and defining relationships between them.

		Goals of Normalization :
			
			-Eliminate redundant data (e.g., storing the same data in multiple places).

			-Ensure data dependencies make sense (data is logically stored).

			-Improve data consistency and integrity.

			-Make the database easier to maintain and extend.
			
		Benefits of Normalization :
			
			-Less data duplication

			-Easier to update and maintain

			-Better data integrity

			-Improved query efficiency (in many cases)
			
		Downsides :
			
			-Can result in more complex queries due to multiple table joins.

			-Over-normalization may hurt performance in read-heavy systems.



10) What does a join in MySQL mean?

		In MySQL, a JOIN is used to combine rows from two or more tables based on a related column between them, 
		usually a foreign key.



11) What do you understand about DDL, DCL, and DML in MySQL?

		In MySQL (or any SQL-based database), SQL commands are categorized into DDL, DML, and DCL, based on their function.

		1. DDL – Data Definition Language
		Purpose: Defines or modifies the structure of the database and its objects like tables, indexes, schemas.

		DDL Commands:
			CREATE – to create tables, databases, views, etc.

			ALTER – to modify existing structures (e.g., add or drop a column).

			DROP – to delete tables, databases, or other objects.

			TRUNCATE – to delete all records from a table (faster than DELETE, resets identity).
			
		2. DML – Data Manipulation Language
		Purpose: Deals with the data inside the database objects (tables).

		DML Commands:
			INSERT – adds new records to a table.

			UPDATE – modifies existing data.

			DELETE – removes data from a table.

			SELECT – retrieves data (sometimes considered part of DQL: Data Query Language).
			
		3. DCL – Data Control Language
		Purpose: Manages permissions and access control for the database.

		DCL Commands:
			GRANT – gives users access rights (e.g., to read/write a table).

			REVOKE – removes access rights from users.
    


12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins?

		The JOIN clause in MySQL is used to combine rows from two or more tables based on a related column (usually a foreign key). 
		It allows you to write queries that retrieve meaningful, connected data from normalized database structures.

		Why Use JOINs?

			-To retrieve data spread across multiple related tables.

			-To reduce redundancy and follow normalization principles.

			-To make your queries more efficient and meaningful.
			
		JOIN Type	Returns
		INNER JOIN	Only matching rows in both tables
		LEFT JOIN	All rows from left, matched rows from right
		RIGHT JOIN	All rows from right, matched rows from left
		FULL JOIN*	All rows from both tables (MySQL: simulate via UNION)

		JOIN Syntax (General Form) :
			SELECT columns
			FROM table1
			JOIN table2 ON table1.common_column = table2.common_column;
*/


