select * from customers;
select customernumber from customers;
select customernumber,customername,state,creditlimit from customers
	where state is null;
select coalesce(state) from customers;
select coalesce(state,"-") from customers;
-- DAY 3
-- 1)Show customer number, customer name, state and credit limit from customers table for below conditions. Sort the results by highest to lowest values of creditLimit.
select customernumber,customername,state,creditlimit from customers
where state is not null 
and creditLimit between 50000 and 100000
order by creditLimit desc;

-- 2.Show the unique productline values containing the word cars at the end from products table.
select productline from productlines
where productline like "%cars"
group by productLine;

-- DAY 4
-- 1.Show the orderNumber, status and comments from orders table for shipped status only. If some comments are having null values then show them as “-“.
select * from orders;
select ordernumber,status,coalesce(comments,"-") from orders
where status ="shipped";

-- 2.Select employee number, first name, job title and job title abbreviation from employees table based on following conditions.
select * from employees;
select employeenumber,firstname,jobtitle,
case
when jobtitle = "President" then "P"
when jobTitle = "Sales rep" then "SR"
when jobtitle like "Sale% manager%" then "SM"
else "VP"
end as job_abbr from employees
order by jobtitle;

-- DAY 5
-- 1.For every year, find the minimum amount value from payments table.
select * from payments;
select year(paymentdate) as Year,min(amount) as "Min Amount" from payments
where year(paymentdate)=2003 or
year(paymentdate)=2004 or
year(paymentdate)=2005
group by year(paymentdate)
order by year;
/*select min(amount) from payments
where year(paymentdate)=2003;*/

-- 2.For every year and every quarter, find the unique customers and total orders from orders table. Make sure to show the quarter as Q1,Q2 etc.
select * from orders;

select year(orderdate) as "Year",concat("Q",quarter(orderdate))as "Quarter", count(distinct( customerNumber)) as "Unique customers", count(quarter(orderdate)) as "Total orders"from orders
group by year(orderdate),concat("Q",quarter(orderdate));
-- select concat("Quit",4);

-- 3.Show the formatted amount in thousands unit (e.g. 500K, 465K etc.) for every month (e.g. Jan, Feb etc.) with filter on total amount as 500000 to 1000000. Sort the output by total amount in descending mode.
select * from payments;
select monthname(paymentdate) as Month,concat(substring(round(sum(amount),-3),1,3),"K") as "Formatted Amount" from payments
-- where sum(amount)<1000000
group by monthname(paymentdate)
order by concat(substring(round(sum(amount),-3),1,3),"K") desc;

-- DAY 6
-- 1.Create a journey table with following fields and constraints.
create table journey (
Bus_ID int not null,
Bus_Name varchar(20) not null,
Source_Station varchar(25) not null,
Destination varchar(25) not null,
Email varchar(30) not null unique);
describe journey;
drop table journey;

-- 2.)Create vendor table with following fields and constraints.
create table Vendor(
Vendor_ID int not null unique,
Name varchar(25) not null,
Email varchar(30) unique,
country varchar(20) default "N/A");
describe vendor;

-- 3.Create movies table with following fields and constraints.
create table movies(
Movie_ID int not null unique,
Name varchar(25) not null,
Release_Year varchar(4) default "-",
Cast varchar(50) not null,
Gender char(1),
No_of_shows int check(No_of_shows >0),
check(Gender in ('M','F')));

describe movies;
drop table movies;

-- 4.Create the following tables. Use auto increment wherever applicable
create table product(
product_id int not null auto_increment,
product_name varchar(20) not null unique,
description varchar(50),
supplier_id int,
primary key(product_id),
foreign key(supplier_id) references suppliers(supplier_id));
describe product;

create table suppliers(
supplier_id int not null auto_increment,
supplier_name varchar(25),
location varchar(20),
primary key (supplier_id));
describe suppliers;

create table stock(
Id int not null,
product_id int,
balance_stock varchar(30),
primary key (Id),
foreign key(product_id) references product(product_id));
describe stock;

-- DAY 7
-- 1.Show employee number, Sales Person (combination of first and last names of employees), unique customers for each employee number and sort the data by highest to lowest unique customers.
select * from employees;
select * from customers;
select employeenumber,concat(firstname," ",lastname) as "sales person" from employees;

/*select lastname,contactlastname from employees inner join customers
on employees.lastName=customers.contactLastName;*/

-- 2.Show total quantities, total quantities in stock, left over quantities for each product and each customer. Sort the data by customer number.
select * from customers;
select * from orders;
select * from orderdetails;
select * from products;

/*select a.customernumber,customername from customers as a left join orders as b
on a.customerNumber=b.customerNumber;

select d.productCode,productname,quantityOrdered,quantityInStock,quantityInStock-quantityOrdered from orderdetails as c left join products as d
on c.productCode=d.productcode;*/

select a.customernumber,customername,d.productCode,productname,quantityOrdered,quantityInStock,quantityInStock-quantityOrdered
from customers as a left join orders as b
on a.customerNumber=b.customerNumber
left join orderdetails as c
on b.ordernumber=c.ordernumber
left join products as d
on c.productCode=d.productcode
order by customernumber;
/*select a.customernumber,customername,c.productcode,productname,quantityordered,quantityInStock,quantityInStock-quantityOrdered 
from customers as a,orders as b,orderdetails as c,products as d
where a.customerNumber=b.customerNumber and c.productCode=d.productcode;*/

-- 3.Perform cross join between the two tables and find number of rows.
create table laptop(laptop_name varchar(20));
create table colours(colour_name varchar(20));
describe laptop;
describe colours;
insert into laptop (laptop_name)
values("Dell"),("HP"),("Acer");
insert into colours 
values ("Silver"),("Black"),("Red");
select * from colours;
select * from laptop;
select laptop_name,colour_name from colours cross join laptop;

-- 4.Find out the names of employees and their related managers.
Create table project(
Employee_ID int ,
FullName varchar (20),
Gender char (6),
Manager_ID int);
select * from project;
INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);

select a.fullname as manager_name,b.fullname as employee_name from project as a join project as b
on b.manager_ID=a.Employee_ID;

-- DAY 8
-- 1.Alter the table by adding the primary key and auto increment to Facility_ID column.
create table facility(
Facility_ID int,
Name varchar(100),
State varchar(100),
Country varchar(100));
describe facility;
/*alter table facility 
add primary key(facility_id);
alter table facility drop primary key;*/
alter table facility 
modify facility_id int primary key auto_increment;
alter table facility
add column City varchar(100) not null after name;

-- DAY 9.Remove the spaces from everywhere and update the column like Pune University etc.
create table university(
ID int ,
Name varchar(100));
INSERT INTO University
VALUES (1, "       Pune          University     "), 
               (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
              (4, "Madras University"),
              (5, "Nagpur University");
/*elect trim(name) as name from university;
update university set name=trim(name);
select * from university;
select replace(replace(replace(name," ","|"),"|"," "),"|"," ") from university;
select id,ltrim(name) from university;*/
select id,ltrim(replace(name, "     "," "))as Name from university;

-- DAY 10.Create the view products status. Show year wise total products sold. Also find the percentage of total value for each year
select * from orderdetails;
select * from orders;
/*select year(orderdate) from orders;
select (quantityOrdered * priceeach) from orderdetails;
select year(orderdate),(quantityOrdered * priceeach) from orders left join orderdetails
on orderdetails.ordernumber=orders.ordernumber;*/

SELECT YEAR(orderdate) AS Year,CONCAT(sum(quantityOrdered * priceeach),'(',
ROUND((SUM(quantityOrdered * priceeach) / (SELECT SUM(quantityOrdered * priceeach) FROM orderdetails)) * 100,0),
'%)') AS Value_Percentage FROM orders LEFT JOIN orderdetails
ON orderdetails.ordernumber = orders.ordernumber
GROUP BY Year
ORDER BY Year DESC;

-- DAY 11
-- 1.Create a stored procedure GetCustomerLevel which takes input as customer number and gives the output as either Platinum, Gold or Silver as per below criteria.
select * from customers;
call excelr.Getcustomerlevel(103);

-- 2.Create a stored procedure Get_country_payments which takes in year and country as inputs and gives year wise, country wise total amount as an output. Format the total amount to nearest thousand unit (K)
select * from customers;
select * from payments;
call excelr.Get_country_payments(2003, 'France');

-- DAY 12
-- 1.Calculate year wise, month name wise count of orders and year over year (YoY) percentage change. Format the YoY values in no decimals and show in % sign.
select * from orders;
SELECT YEAR(OrderDate) AS OrderYear,MONTHNAME(OrderDate) AS MonthName,COUNT(*) AS OrderCount
FROM Orders
GROUP BY
OrderYear, MonthName
ORDER BY
OrderYear, Month(monthName);

-- 2.Create a user defined function calculate_age which returns the age in years and months (e.g. 30 years 5 months) by accepting DOB column as a parameter.
-- Create the table emp_udf
CREATE TABLE emp_udf (
    Emp_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    DOB DATE
);

-- Insert data into emp_udf
INSERT INTO emp_udf (Name, DOB)
VALUES 
    ('Piyush', '1990-03-30'),
    ('Aman', '1992-08-15'),
    ('Meena', '1998-07-28'),
    ('Ketan', '2000-11-21'),
    ('Sanjay', '1995-05-21');

select excelr.calculate_age('2000-11-21');

-- DAY 13
-- 1.Display the customer numbers and customer names from customers table who have not placed any orders using subquery
SELECT customerNumber, customerName
FROM Customers
WHERE customerNumber NOT IN (SELECT DISTINCT customerNumber FROM Orders);

-- 2.Write a full outer join between customers and orders using union and get the customer number, customer name, count of orders for every customer.
select * from customers;
select *from orders;
   
SELECT Customers.customerNumber, Customers.customerName, COUNT(Orders.orderNumber) AS TotalOrders
FROM Customers LEFT JOIN Orders 
ON Customers.customerNumber = Orders.customerNumber
GROUP BY customerNumber, customerName
UNION
SELECT Customers.customerNumber, Customers.customerName, COUNT(Orders.orderNumber) AS TotalOrders
FROM Orders LEFT JOIN Customers 
ON Customers.customerNumber = Orders.customerNumber
WHERE Customers.customerNumber IS NULL
GROUP BY customerNumber, customerName
ORDER BY customerNumber;

-- 3.Show the second highest quantity ordered value for each order number.
select * from orderdetails;

SELECT OrderNumber,QuantityOrdered AS SecondHighestQuantity
FROM (SELECT OrderNumber,QuantityOrdered,
        RANK() OVER (PARTITION BY OrderNumber ORDER BY QuantityOrdered DESC) AS RowRank
    FROM Orderdetails) AS RankedOrderDetails
WHERE
    RowRank = 2;
/*select ordernumber,quantityordered,
rank() over (partition by ordernumber order by quantityordered desc) as "Rank" from orderdetails
where "rank"=2;*/

-- 4.For each order number count the number of products and then find the min and max of the values among count of orders.
select * from orderdetails;
select max(total) as MaxTotal,min(total)as MinTotal from (select ordernumber,count(*) as total from orderdetails
group by ordernumber) as Singleproduct;

-- 5.Find out how many product lines are there for which the buy price value is greater than the average of buy price value. Show the output as product line and its count.
WITH ProductLineAvgBuyPrice AS (SELECT productLine, AVG(buyPrice) AS AvgBuyPrice FROM Products
GROUP BY productLine)
SELECT p.productLine,COUNT(*) AS Total FROM Products p JOIN ProductLineAvgBuyPrice pa
ON p.productLine = pa.productLine
WHERE p.buyPrice > pa.AvgBuyPrice
GROUP BY p.productLine;
 
 -- DAY 14.Create a procedure to accept the values for the columns in Emp_EH. Handle the error using exception handling concept. Show the message as “Error occurred” in case of anything wron
 call excelr.Insert_Emp_EH(104, 'harini', 'harini07@gmail.com');
 
 -- DAY15.Create before insert trigger to make sure any new value of Working_hours, if it is negative, then it should be inserted as positive.
CREATE TABLE Emp_BIT (
    Name VARCHAR(255),
    Occupation VARCHAR(255),
    Working_date DATE,
    Working_hours INT);

INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),
('Warner', 'Engineer', '2020-10-04', 10),
('Peter', 'Actor', '2020-10-04', 13),
('Marco', 'Doctor', '2020-10-04', 14),
('Brayden', 'Teacher', '2020-10-04', 12),
('Antonio', 'Business', '2020-10-04', 11);
select * from Emp_BIT ;
DELIMITER //

CREATE TRIGGER before_insert_Emp_BIT
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    -- Make sure Working_hours is inserted as positive
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = ABS(NEW.Working_hours);
    END IF;
END //

DELIMITER ;

  -- Try to insert a record with a negative Working_hours
INSERT INTO Emp_BIT VALUES ('John', 'Manager', '2020-10-05', -8);
INSERT INTO Emp_BIT VALUES ('Johni', 'Manager', '2020-10-05', -8);
INSERT INTO Emp_BIT VALUES ('Johnny', 'employee', '2020-10-05', -9);
-- Check the contents of Emp_BIT
SELECT * FROM Emp_BIT;


























