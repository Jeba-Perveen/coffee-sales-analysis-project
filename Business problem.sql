-- BUSSINESS QUESTIONS
/*Q1
Coffee Consumers Count
How many people in each city are estimated to consume coffee, given that 25% of the population does?
*/
select city_name,
	   concat(round((population*0.25 )/1000000,2) , ' Million') as coffee_consumers,
	   city_rank
from city;


-- converting date type from nvachar to date of sale_date column
update sales 
set sale_date = convert(nvarchar(15),try_convert(date,sale_date,105),23)
where TRY_CONVERT(date,sale_date,105) is not null

alter table sales
alter column sale_date date;

/*Q2.
Total Revenue from Coffee Sales
What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
*/
select ci.city_name,
	   sum(total) as total_revenue
from sales s
join customers c 
on c.customer_id = s.customer_id
left join city ci
on ci.city_id = c.city_id
where DATEPART(quarter,sale_date) = 4
	  and YEAR(sale_date) = 2023
group by
		 ci.city_name


/*Q3.
Sales Count for Each Product
How many units of each coffee product have been sold?
*/
select p.product_name,
	   count(s.sale_id) as total_orders
from products p
left join sales s
on p.product_id = s.product_id
where p.product_name like '%Coffee%'
group by p.product_name


/*Q4
Average Sales Amount per City
What is the average sales amount per customer in each city?
*/
select ci.city_name,
	   sum(s.total) as total_revenue,
	   count(distinct s.customer_id) as total_cust,
	   sum(s.total)/count(distinct s.customer_id) as avg_sale_per_cust
from city ci
left join customers c
on ci.city_id = c.city_id
left join sales s
on s.customer_id = c.customer_id
group by ci.city_name


/*Q5
City Population and Coffee Consumers
Provide a list of cities along with their populations and estimated coffee consumers.
*/
select ci.city_name,
	   ci.population,
	   p.product_name,
	   c.customer_name,
	   concat(round((population*0.25 )/1000000,2) , ' Million') as coffee_consumers 
from city ci
left join customers c
on c.city_id = ci.city_id
join sales s on
s.customer_id = c.customer_id
join products p
on p.product_id = s.product_id
where p.product_name like '%Coffee%'



/*Q6
Top Selling Products by City
What are the top 3 selling products in each city based on sales volume?
*/
select city_name,
	   product_name,
	   total_revenue
from(
	select ci.city_name,
		   p.product_name,
		   sum(s.total) as total_revenue,
		   DENSE_RANK() over(partition by ci.city_name order by sum(s.total) desc) as rnk
	from city ci
	left join customers c
	on c.city_id = ci.city_id
	join sales s
	on s.customer_id = c.customer_id
	join products p
	on p.product_id = s.product_id
	group by ci.city_name,
			 p.product_name)t
where rnk<=3
 

/*Q7
Customer Segmentation by City
How many unique customers are there in each city who have purchased coffee products?
*/
select ci.city_name,
	   count(distinct c.customer_id) as unique_cust
from city ci
left join customers c
on c.city_id = ci.city_id
join sales s 
on c.customer_id = s.customer_id
where product_id <= 14
group by ci.city_name;


/*Q8
Average Sale vs Rent
Find each city and their average sale per customer and avg rent per customer
*/
with details as (
	select c.city_name,
		   c.estimated_rent,
		   count(distinct cu.customer_id) as total_customers,
		   sum(s.total) as total_sale
	from city c
	left join customers cu
	on c.city_id = cu.city_id
	join sales s
	on cu.customer_id = s.customer_id
	group by c.city_name,
		   c.estimated_rent)
select city_name,
	   estimated_rent,
	   total_customers,
	   total_sale,
	   total_sale/total_customers as avg_sale_per_cust,
	   estimated_rent/total_customers as avg_rent_per_cut
from details;

/*Q9
Monthly Sales Growth
Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly).
*/
with monthly_sales as (
	select ci.city_name,
		   month(s.sale_date) as month,
		   year(s.sale_date) as year,
		   sum(s.total) as total_revenue
	from sales s
	join customers c
	on c.customer_id = s.customer_id
	join city ci
	on ci.city_id = c.city_id
	group by ci.city_name,
		   month(s.sale_date) ,
		   year(s.sale_date)
 ),
growth_ratio as (
	select city_name,
		   month,
		   year,
		   total_revenue as current_month_sales,
		   lag(total_revenue) over(partition by city_name order by year,month) as last_month_sales
	from monthly_sales)
select city_name,
	   month,
	   year,
	   current_month_sales,
	   last_month_sales,
	  round( ((cast((current_month_sales-last_month_sales) as float)/last_month_sales)*100 ) ,2) as growth
from growth_ratio

/*
Market Potential Analysis
Identify top 3 city based on highest sales.
return city name,total sale, total rent, total customers, estimated coffee consumer 
*/
select city_name,
	   total_sales,
	   total_rent,
	   total_customers,
	   coffee_consumers
from(
	select ci.city_name,
		   sum(s.total) as total_sales,
		   sum(ci.estimated_rent) as total_rent,
		   count(distinct c.customer_id) as total_customers,
		   concat(round((ci.population*0.25 )/1000000,2) , ' Million') as coffee_consumers,
		   row_number() over( order by sum(s.total) desc) as rnk
	from city ci
	left join customers c
	on c.city_id = ci.city_id
	join sales s
	on s.customer_id = c.customer_id
	group by ci.city_name,concat(round((ci.population*0.25 )/1000000,2) , ' Million')
	)t
where rnk<=3

