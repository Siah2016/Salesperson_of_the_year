-- Problem 1 & 2
-- 1. Using JOINs in a single query, combine data from all three tables (employees, products, sales) to view all sales with complete employee and product information in one table.
SELECT SalesID, FirstName, LastName, SalesPersonID, CustomerID, Quantity, products.ProductID, Name, Price
FROM sales INNER JOIN employees ON employees.EmployeeID = sales.SalesPersonID LEFT JOIN products ON products.ProductID = sales.ProductID;
-- 2a. Create a View for the query you made in Problem 1 named "all_sales"
-- NOTE: You'll want to remove any duplicate columns to clean up your view!
CREATE VIEW all_sales
AS
SELECT SalesID, FirstName, LastName, SalesPersonID, CustomerID, Quantity, products.ProductID, Name, Price
FROM sales INNER JOIN employees ON employees.EmployeeID = sales.SalesPersonID LEFT JOIN products ON products.ProductID = sales.ProductID;

-- 2b. Test your View by selecting all rows and columns from the View
SELECT salesid FROM all_sales;
SELECT firstname FROM all_sales;
SELECT lastname FROM all_sales;
SELECT salespersonid FROM all_sales;
SELECT customerid FROM all_sales;
SELECT quantity FROM all_sales;
SELECT productid FROM all_sales;
SELECT name FROM all_sales;
SELECT price FROM all_sales;
-- Problem 3
-- Find the average sale amount for each sales person
SELECT firstname, avg(price) as Average_sales_amount
FROM all_sales
group by firstname;
-- Problem 4
-- Find the top three sales persons by total sales
SELECT firstname, count(price) as total_sales
FROM all_sales
group by firstname
order by total_sales desc
limit 3;
-- Problem 5
-- Find the product that has the highest price
SELECT name, price
FROM all_sales
order by price desc
limit 1;
-- Problem 6
-- Find the product that was sold the most times
SELECT  name, count(salespersonid) 
FROM all_sales
group by name
order by count(salespersonid) desc
limit 1;
-- Problem 7
-- Using a subquery, find all products that have a price higher than the average price for all products
SELECT avg(price) as average_price
from all_sales 
where name in (select price from all_sales where price > avg(price))
order by price desc
-- Problem 8
-- Find the customer who spent the most money in purchased products
SELECT  customerid, price
FROM all_sales
order by price desc 
limit 1;
-- Problem 9
-- Find the total number of sales for each sales person
SELECT  firstname, count(salespersonid) 
FROM all_sales
group by firstname
order by count(salespersonid) desc;
-- Problem 10
-- Find the sales person who sold the most to the customer you found in Problem 8
SELECT  firstname, salespersonid, salesid, customerid, price
FROM all_sales
where customerid = 18723
order by price desc 