create Database Sql_project;

 create table retail_sales
 (transactions_id int,	
 sale_date	date,
 sale_time	time,
 customer_id	int,
 gender	varchar(20),
 age	int,
 category	varchar(30),
 quantiy	int,
 price_per_unit	float(10,2),
 cogs	float(10,2),
 total_sale float(10,2)
); 
 
 select	* from retail_sales;
 
 select count(*)
 from retail_sales;
 
 
 -- Data cleaning  
select * from retail_sales
    where 
    sale_date IS NULL OR 
    sale_time IS NULL OR 
    customer_id IS NULL OR 
    gender IS NULL OR 
    age IS NULL OR 
    category IS NULL OR 
   price_per_unit IS NULL OR 
   cogs IS NULL;
   
 -- how many sales have ?
 select count(*) as total_sale from retail_sales;
 
 
 -- How many unique coustmer we have ?
 select count(distinct customer_id ) from retail_sales;
 
 
 -- How many unique category we have ?
 select distinct category from retail_sales;
 
 -- Data analysis business key problems & answer 
 
 -- 1.  Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
 
 select * 
 from retail_sales
 where sale_date = "2022-11-05" ;
 
-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 **:
   
select  category , sum(quantiy)
from retail_sales
where category = "clothing" 
and quantiy >= 4;

-- 3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

select category , 
  sum(total_sale) as net_sales , count(*) as net_order
from retail_sales
group by 1;

-- 4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

select 
round(avg(age), 2)
from retail_sales
where category = "Beauty" ;

-- 5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
select * from retail_sales
where total_sale >1000;

-- 6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

select category, gender , count(*) 
from retail_sales 
group by category, gender ;

-- 7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) 
FROM retail_sales
GROUP BY 1, 2 
;

-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id,
sum(total_sale) total_sale
from retail_sales 
group by 1
order by 1 desc
limit 5;

-- 9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

select  category, count(distinct customer_id) as unique_coustmer
from retail_sales
group by category;

-- 10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift, COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

-- End of Project 




 
 
 
 



