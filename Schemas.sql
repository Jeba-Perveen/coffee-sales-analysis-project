create database coffee;


Drop table if exists city;
create table city(
		city_id         int,
		city_name       nvarchar(100),
		population      int,
		estimated_rent  int,
		city_rank       int);

bulk insert city
from 'C:\Users\jebap\Downloads\archive\city.csv'
with (
		fieldterminator = ',',
		firstrow = 2,
		tablock,
		keepnulls);

select * from city;
----------------------------------------------------------------------

Drop table if exists customers;
create table customers(
		customer_id     int,
		customer_name   nvarchar(50),
		city_id			int)

bulk insert customers
from 'C:\Users\jebap\Downloads\archive\customers.csv'
with (
		fieldterminator = ',',
		firstrow = 2,
		tablock,
		keepnulls);

select * from  customers;
-----------------------------------------------------------------------------

Drop table if exists products;
create table products(
			product_id		int,
			product_name    nvarchar(40),
			price			int);


bulk insert products
from 'C:\Users\jebap\Downloads\archive\products.csv'
with (
		fieldterminator = ',',
		firstrow = 2,
		tablock,
		keepnulls);

select * from products;
-------------------------------------------------------------------------

Drop table if exists sales;
create table sales(
		sale_id int,
		sale_date nvarchar(15),	
		product_id int,
		customer_id	 int,
		total	int,
		rating int)

bulk insert sales
from 'C:\Users\jebap\Downloads\archive\sales.csv'
with (
		fieldterminator = ',',
		firstrow = 2,
		tablock,
		keepnulls);

select * from sales;
----------------------------------------------------------------------------------------
