-- Create database
CREATE DATABASE IF NOT EXISTS DataWalmart;

-- Create table
USE DataWalmart;
CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10, 2) NOT NULL,
    gross_margin_pct FLOAT,
    gross_income DECIMAL(12, 4),
    rating FLOAT
) ENGINE=InnoDB;

-- ------------Data Cleaning ------------

SELECT *
FROM sales
LIMIT 10;

-- Turn off safe mode for updates
SET SQL_SAFE_UPDATES = 0;


-- Add Column time_of_day
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- Fill column time_of_day
UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- Add and fill day_name column 
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- Add and fill month_name column
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

-- Restore safe mode
SET SQL_SAFE_UPDATES = 1;

-- ------------Exploratory Data Analysis ------------
-- ------------ General Questions ------------
-- How many and which cities does the data have?
SELECT DISTINCT city
FROM sales;

-- In which city is each branch?
SELECT DISTINCT city, branch
FROM sales;

-- ------------ Product Questions ------------
-- How many unique product lines does the data have?
SELECT DISTINCT product_line
FROM sales;

-- What is the most common payment method?
SELECT payment, COUNT(payment) AS count
FROM sales
GROUP BY payment
ORDER BY count DESC; 

-- What is the most selling product line?
SELECT product_line, COUNT(product_line) AS count
FROM sales 
GROUP BY product_line
ORDER BY count DESC ; 

-- What is the total revenue by month?
SELECT month_name, SUM(total) AS total_revenue
FROM sales 
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS?
SELECT month_name, SUM(cogs) AS total_cogs
FROM sales 
GROUP BY month_name
ORDER BY total_cogs DESC;

-- What product line had the largest revenue?
SELECT product_line, SUM(total) AS total_revenue
FROM sales 
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT city, SUM(total) AS total_revenue
FROM sales 
GROUP BY city
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?
SELECT product_line, AVG(tax_pct) AS avg_tax
FROM sales 
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT AVG(quantity) AS avg_quantity
FROM SALES;

SELECT product_line, 
	(CASE 
		WHEN AVG(quantity) >= 5.51 THEN "Good"
		ELSE "Bad" 
	END) AS clasification 
FROM sales
GROUP BY product_line;

-- Which branch sold more products than average product sold?
SELECT 
	branch, 
	SUM(quantity) AS qnty
FROM sales 
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales)
ORDER BY qnty DESC;

-- What is the most common product line by gender?
SELECT 
	gender, 
    product_line,
    COUNT(gender) AS count
FROM sales
GROUP BY gender, product_line
ORDER BY count DESC;

-- What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating), 2) AS avg_rating 
FROM sales 
GROUP BY product_line
ORDER BY avg_rating DESC ; 

-- ------------ Sales Questions ------------
-- Number of sales made in each time of the day per weekday
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday" -- Change weekday 
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC; 

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-- ------------ Customer Questions ------------
-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM sales;

-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;


-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;


-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;


