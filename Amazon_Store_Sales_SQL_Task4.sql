
-- Task 4: SQL for Data Analysis
-- Dataset: Amazon Store Sales Data.xlsx - Sheet1 (1)
-- Table Name: amazon_store_sales_data

-- 1. Create Table
CREATE TABLE amazon_store_sales_data (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(255),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(10,2),
    quantity INT,
    profit DECIMAL(10,2),
    returns VARCHAR(10),
    payment_mode VARCHAR(50)
);

-- 2. Basic Query: SELECT + WHERE + ORDER BY
SELECT order_id, customer_name, country, sales
FROM amazon_store_sales_data
WHERE country = 'United States'
ORDER BY sales DESC
LIMIT 10;

-- 3. GROUP BY + Aggregation
SELECT category, SUM(profit) AS total_profit
FROM amazon_store_sales_data
GROUP BY category
ORDER BY total_profit DESC;

-- 4. Create Customers table using DISTINCT + JOIN Example
CREATE TABLE customers AS
SELECT DISTINCT customer_id, customer_name, segment, country, city, state, region
FROM amazon_store_sales_data;

SELECT c.customer_name, a.order_id, a.sales
FROM amazon_store_sales_data a
INNER JOIN customers c
ON a.customer_id = c.customer_id;

-- 5. Subquery: Best-selling Product
SELECT product_name, sales
FROM amazon_store_sales_data
WHERE product_id IN (
    SELECT product_id
    FROM amazon_store_sales_data
    GROUP BY product_id
    ORDER BY SUM(sales) DESC
    LIMIT 1
);

-- 6. Create View
CREATE VIEW customer_sales_summary AS
SELECT customer_id, customer_name,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit,
       SUM(quantity) AS total_quantity
FROM amazon_store_sales_data
GROUP BY customer_id, customer_name;

SELECT * FROM customer_sales_summary
ORDER BY total_sales DESC;

-- 7. Create Index
CREATE INDEX idx_category ON amazon_store_sales_data(category);

-- 8. Bonus: Return Tracking
SELECT customer_name, product_name, returns
FROM amazon_store_sales_data
WHERE returns = 'Yes';

-- 9. Sales by Payment Mode
SELECT payment_mode, SUM(sales) AS total_sales
FROM amazon_store_sales_data
GROUP BY payment_mode
ORDER BY total_sales DESC;

-- 10. Region Performance Report
SELECT region, SUM(profit) AS region_profit
FROM amazon_store_sales_data
GROUP BY region
ORDER BY region_profit DESC;

