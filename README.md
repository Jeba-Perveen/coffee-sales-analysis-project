# coffee-sales-analysis-project


## Project Overview
This project analyzes coffee sales data across multiple cities to derive insights about consumer behavior, revenue trends, and market potential. The analysis uses SQL Server to process data from four main tables: cities, customers, products, and sales.

## Database Schema

### Tables
1. **city** - Contains city-level demographic and economic data
   - `city_id`: Unique identifier for each city
   - `city_name`: Name of the city
   - `population`: Total population
   - `estimated_rent`: Average rental cost
   - `city_rank`: Ranking of the city

2. **customers** - Customer information
   - `customer_id`: Unique identifier for each customer
   - `customer_name`: Name of the customer
   - `city_id`: Foreign key linking to city table

3. **products** - Product catalog
   - `product_id`: Unique identifier for each product
   - `product_name`: Name of the product
   - `price`: Product price

4. **sales** - Transaction records
   - `sale_id`: Unique identifier for each sale
   - `sale_date`: Date of transaction
   - `product_id`: Foreign key linking to products
   - `customer_id`: Foreign key linking to customers
   - `total`: Total sale amount
   - `rating`: Customer rating

## Business Questions Analyzed

### 1. Coffee Consumer Estimation
Calculates estimated coffee consumers per city (25% of population).

### 2. Q4 2023 Revenue Analysis
Total revenue generated from coffee sales in the last quarter of 2023, broken down by city.

### 3. Product Sales Volume
Count of units sold for each coffee product.

### 4. Average Sales per Customer
Average sales amount per customer segmented by city.

### 5. City Demographics
Comprehensive list of cities with population and estimated coffee consumers.

### 6. Top Selling Products
Identifies top 3 selling products in each city based on revenue.

### 7. Customer Segmentation
Count of unique customers per city who purchased coffee products.

### 8. Sales vs Rent Analysis
Comparison of average sales per customer against average rent per customer by city.

### 9. Monthly Sales Growth
Calculates month-over-month sales growth percentage for each city.

### 10. Market Potential Analysis
Identifies top 3 cities based on highest sales with comprehensive metrics including total sales, rent, customers, and estimated coffee consumers.

## Setup Instructions

### Prerequisites
- SQL Server (2016 or later)
- SQL Server Management Studio (SSMS)
- CSV data files:
  - `city.csv`
  - `customers.csv`
  - `products.csv`
  - `sales.csv`

### Installation Steps

1. **Create Database**
   ```sql
   create database coffee;
   ```

2. **Update File Paths**
   Modify the file paths in the BULK INSERT statements to match your local directory:
   ```sql
   from 'C:\Users\jebap\Downloads\archive\city.csv'
   ```

3. **Execute SQL Script**
   Run the entire `coffee data.sql` script to:
   - Create tables
   - Load data from CSV files
   - Execute all business queries

4. **Date Conversion**
   The script includes a date format conversion for the `sale_date` column to ensure proper date handling.

## Key Insights

- **Consumer Estimation**: 25% of city population is assumed to be coffee consumers
- **Sales Performance**: Tracks revenue trends across cities and time periods
- **Product Analysis**: Identifies best-performing products by location
- **Market Opportunity**: Combines sales data with demographic information to identify expansion opportunities

## Query Highlights

### Growth Calculation
Uses window functions (LAG) to calculate month-over-month growth rates.

### Ranking Analysis
Employs DENSE_RANK and ROW_NUMBER for identifying top performers.

### Aggregation Metrics
Comprehensive use of SUM, COUNT, and AVG functions for business intelligence.

## Usage

Each query in the script is commented with its business question. To run specific analyses:

1. Open the script in SSMS
2. Navigate to the desired query section
3. Execute the query independently or run the entire script

## Future Enhancements

- Add data validation and error handling
- Implement stored procedures for recurring analyses
- Create views for frequently accessed metrics
- Add indexes for performance optimization
- Develop visualization dashboards

## Data Assumptions

- 25% of population are coffee consumers
- Product IDs 1-14 represent coffee products
- Sales data uses DD-MM-YYYY format initially

## Author
Jeba Perveen

