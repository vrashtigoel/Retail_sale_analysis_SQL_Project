create database sql_project_p2;

-- Create Table
DROP TABLE IF EXISTS retail_sale;
CREATE TABLE retail_sale
            (
             transactions_id int PRIMARY KEY,
             sale_date date,
             sale_time TIME,
             customer_id INT,
             gender VARCHAR(15),
             age INT,
             category VARCHAR(15),
             quantity INT,
             price_per_unit FLOAT,
             cogs FLOAT,
             total_sale FLOAT
		);
        
Select * from retail_sale;
Select count(*) from retail_sale;

Select * from retail_sale
where 
	transactions_id IS NULL
	or
    sale_date IS NULL
    or
    sale_time IS NULL
    or
    customer_id IS NULL
    or
    gender IS NULL
    or
    age IS NULL
    or
    category IS NULL
    or
    quantity IS NULL
    or
    price_per_unit IS NULL
    or
	cogs IS NULL
    or
    total_sale IS NULL;

-- Q-1 Write a SQL Query to retrieve all columns for sales made on '2022-11-05'.

SELECT * from retail_sale
where sale_date = '2022-11-05';

-- Q-2 WQrite an SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 3 in the month of nov-2022.

select * 
from retail_sale
where category = 'clothing'
and quantity >= 4
AND MONTH(sale_date) = 11 AND YEAR(sale_date) = 2022;

-- Q-3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, SUM(total_sale) as total_sales,
count(*) as total_orders
from retail_sale
group by category;

-- Q-4 Write a SQL Query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) as average_age
from retail_sale
where category = 'Beauty';

-- Q-5 write a sql query to find all transaction where the total_sale is greater than 1000.

select * from retail_sale
where total_sale > 1000;

-- Q-6 wrie a sql query to find the total number of transactions (transaction_id) made by each gender in each category.

select category, gender, count(*) as total_transaction
from retail_sale
group by category, gender;

-- Q-7 write a sql query to calculate the average sale for each month. Find out best salary month for each year.

Select * from 
(
select 
     extract(year from sale_date) as year,
	 extract(month from sale_date) as month,
     avg(total_sale) as avg_sale,
     rank() over(partition by extract(year from sale_date) order by avg(total_sale) DESC) as Rank_one
from retail_sale
group by 1,2
) as t1
where Rank_one = 1;
-- order by 1,2 desc;

-- Q-8: Write a sql query to find the top 5 customer based on the highest total sales.

SELECT customer_id, 
sum(total_sale) as total_sales 
from retail_sale 
group by 1
ORDER BY 2 desc
limit 5;

-- QUES-9 Write a sql query to find the number of unique customers who purchased items from each category.

select 
category,
count(distinct customer_id) as unique_customers
from retail_sale
group by 1;

-- Q-10 Write a SQL Query to create each shift & number of orders.

With hourly_sale
as (
select *,
   CASE 
     when Extract(Hour from sale_time) <12 then 'Morning'
     when Extract(Hour from sale_time) Between 12 and 17 then 'Afternoon'
     else 'Evening'
   End as shift
from retail_sale
)
select shift, count(*) as total_orders
from hourly_sale
group by shift;

-- END OF THE PROJECT.