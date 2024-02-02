# Walmart Sales Data Cleaning and Analysis 

## About
This project aims to explore Walmart sales data to uncover trends in the sales patterns. Through this exploration, a strategy can be formulated to enhance and optimize both sales and profits. The dataset includes sales from 45 stores across three different cities, spanning from January 2019 to March 2019.

Dataset retrieved from: [Walmart Recruiting - Store Sales Forecasting](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

## Objective
The purpose of this project is to acquire knowledge about the behavior of sales data in order to recognize patterns and trends, and to optimize and improve Walmart's sales.

## Data Information
This dataset contains transactions of 45 Walmart stores across three different cities Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows.

| Column | Description | Data Type |
| -------- | ------- | ------- |
|invoice_id|Invoice of the sales made|VARCHAR(30)|
|branch|Branch at which sales were made|VARCHAR(5)|
|city|The location of the branch|VARCHAR(30)|
|customer_type|The type of the customer|VARCHAR(30)|
|gender|Gender of the customer making purchase|VARCHAR(10)|
|product_line|Product line of the product solf	|VARCHAR(100)|
|unit_price|The price of each product|DECIMAL(10, 2)|
|quantity	|The amount of the product sold	|INT|
|VAT|The amount of tax on the purchase	|FLOAT(6, 4)|
|total|The total cost of the purchase|DECIMAL(10, 2)|
|date|The date on which the purchase was made|DATE|
|time|The time at which the purchase was made|TIMESTAMP|
|payment_method|The total amount paid|DECIMAL(10, 2)|
|cogs|Cost Of Goods sold|DECIMAL(10, 2)|
|gross_margin_percentage|Gross margin percentage|FLOAT(11, 9)|
|gross_income|Gross Income|DECIMAL(10, 2)|
|rating|Rating|FLOAT(2, 1)|

## Analysis Schema

* **Product Analysis**
  
This analysis aims to describe sales patterns of products, identify top-performing items that generate higher profits, and enhance customer satisfaction. Additionally, it will assist in pinpointing products or branches that require improvement.

* **Sales Analysis**
  
With sales data, we can analyze variations in sales across different dates in the year, identify which city yields higher profits, and assess the effectiveness of sales strategies. This information helps detect whether the sales strategies are working well or need improvement.
  
* **Costumer Analysis**
  
Understanding who the customers are is also important. Through this analysis, it will be possible to identify which type of customers make more purchases, if they have any tendency to buy on specific dates of the year, week, or particular times of the day, as well as their preferred payment methods.

## Step 1: **Data Wrangling:**
* This marks the initial phase where data inspection is conducted to identify NULL values and missing data. Subsequently, data replacement methods are applied to address and substitute these missing or NULL values.
  1. Build the database
  2. Create and insert the data into a table
  3. Set NOT NULL for each column and null values are filtered out.
       
## Step 2: **Feature Engineering:**
*  Creation of new columns derived from existing ones. This process aids in generating additional insights and enhancing the dataset by introducing novel features based on the current data.
  1. Introduce column "time_of_day" to provide insights into sales during the Morning, Afternoon, and Evening periods.
  2. Incorporate a column named "day_name" that captures the weekdays corresponding to the transaction dates (Mon, Tue, Wed, Thur, Fri).
  3. Integrate a new column named "month_name" to record the extracted months of the year for each transaction (Jan, Feb, Mar).
 
  ## Step 3: **Exploratory Data Analysis (EDA):**
  * Exploratory data analysis is undertaken to address the specified questions and objectives outlined in this project.

Product

How many unique product lines does the data have?
What is the most common payment method?
What is the most selling product line?
What is the total revenue by month?
What month had the largest COGS?
What product line had the largest revenue?
What is the city with the largest revenue?
What product line had the largest VAT?
Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
Which branch sold more products than average product sold?
What is the most common product line by gender?
What is the average rating of each product line?
Sales

Number of sales made in each time of the day per weekday
Which of the customer types brings the most revenue?
Which city has the largest tax percent/ VAT (Value Added Tax)?
Which customer type pays the most in VAT?
Customer

How many unique customer types does the data have?
How many unique payment methods does the data have?
What is the most common customer type?
Which customer type buys the most?
What is the gender of most of the customers?
What is the gender distribution per branch?
Which time of the day do customers give most ratings?
Which time of the day do customers give most ratings per branch?
Which day fo the week has the best avg ratings?
Which day of the week has the best average ratings per branch?
