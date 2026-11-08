-- Retail Sales Analysis — MySQL queries
-- Table: sales (order_id, order_date, region, channel, category, product,
--            unit_price, quantity, discount, customer_id, revenue)
-- Load sales_data_clean.csv into this table first.

-- 1. Total revenue and total orders
SELECT COUNT(DISTINCT order_id) AS total_orders,
       SUM(revenue) AS total_revenue,
       ROUND(AVG(revenue), 2) AS avg_line_revenue
FROM sales;

-- 2. Revenue by category
SELECT category, SUM(revenue) AS revenue, COUNT(*) AS lines
FROM sales GROUP BY category ORDER BY revenue DESC;

-- 3. Revenue by region
SELECT region, SUM(revenue) AS revenue
FROM sales GROUP BY region ORDER BY revenue DESC;

-- 4. Revenue by channel
SELECT channel, SUM(revenue) AS revenue, COUNT(DISTINCT order_id) AS orders
FROM sales GROUP BY channel;

-- 5. Top 5 products by revenue
SELECT product, SUM(revenue) AS revenue, SUM(quantity) AS units_sold
FROM sales GROUP BY product ORDER BY revenue DESC LIMIT 5;

-- 6. Monthly revenue trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(revenue) AS revenue
FROM sales GROUP BY month ORDER BY month;

-- 7. Average order value (per order)
SELECT ROUND(AVG(order_total), 2) AS avg_order_value
FROM (SELECT order_id, SUM(revenue) AS order_total FROM sales GROUP BY order_id) t;

-- 8. Best month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(revenue) AS revenue
FROM sales GROUP BY month ORDER BY revenue DESC LIMIT 1;

-- 9. Category share of total revenue
SELECT category,
       SUM(revenue) AS revenue,
       ROUND(100 * SUM(revenue) / (SELECT SUM(revenue) FROM sales), 1) AS pct_of_total
FROM sales GROUP BY category ORDER BY revenue DESC;

-- 10. Orders with a discount vs without — does discounting lift quantity?
SELECT CASE WHEN discount > 0 THEN 'Discounted' ELSE 'Full price' END AS price_type,
       COUNT(*) AS lines, ROUND(AVG(quantity), 2) AS avg_quantity,
       ROUND(AVG(revenue), 2) AS avg_revenue
FROM sales GROUP BY price_type;
