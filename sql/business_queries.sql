-- =========================================
-- E-Commerce Sales Analysis SQL Queries
-- =========================================


-- Revenue by Region

select Region, round(SUM(Sales), 2) AS Revenue
From superstore
group by Region
Order by Revenue Desc;


-- Top 5 Products 

Select `Product Name`, round(SUM(Sales), 2) As Total_Sales
From superstore
group by `Product Name`
order by Total_Sales DESC
Limit 5;


-- Monthly Growth

with monthly_sales as (
select
	YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS year,
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS month,
    SUM(Sales) as revenue
From superstore
group by year, month
)

select *, lag(revenue) over(order by year, month) as previous_month,
round(
((revenue - lag(revenue) over(order by year, month)) / lag(revenue) over(order by year, month)) * 100, 2
) as growth_percentage
from monthly_sales;


-- Repeat Customers

select `Customer Name`,
    COUNT(`Order ID`) AS total_orders
FROM superstore
GROUP BY `Customer Name`
HAVING total_orders > 1
ORDER BY total_orders DESC;


-- Category Performance

select Category, sum(Sales) as revenue, sum(Profit) as Profit
from superstore
group by Category;