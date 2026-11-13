-- Retail Sales Analysis — Advanced SQL (CTEs and window functions)
-- Table: sales (order_id, order_date, region, channel, category, product,
--            unit_price, quantity, discount, customer_id, revenue)
-- Load sales_data_clean.csv into this table first.
-- Dialect: standard SQL window functions — runs on MySQL 8+, PostgreSQL,
-- SQLite and DuckDB. The month key uses strftime on SQLite; on MySQL use
-- DATE_FORMAT(order_date, '%Y-%m'), on PostgreSQL TO_CHAR(order_date, 'YYYY-MM').

-- 1. Monthly revenue with a running total
-- The CTE rolls the raw order lines up to one row per month first,
-- then SUM() OVER turns the monthly figures into a cumulative total.
WITH monthly AS (
    SELECT strftime('%Y-%m', order_date) AS month,
           SUM(revenue) AS revenue,
           COUNT(*) AS orders
    FROM sales
    GROUP BY month
)
SELECT month,
       revenue,
       orders,
       SUM(revenue) OVER (ORDER BY month) AS running_total_revenue
FROM monthly
ORDER BY month;

-- 2. Month-over-month revenue change with LAG
-- LAG reaches back to the previous row in the window, so each month is
-- compared with the month before it (the first month has no predecessor).
WITH monthly AS (
    SELECT strftime('%Y-%m', order_date) AS month,
           SUM(revenue) AS revenue
    FROM sales
    GROUP BY month
),
with_prev AS (
    SELECT month,
           revenue,
           LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue
    FROM monthly
)
SELECT month,
       revenue,
       prev_month_revenue,
       ROUND(revenue - prev_month_revenue, 2) AS change_amount,
       ROUND(100.0 * (revenue - prev_month_revenue) / prev_month_revenue, 1) AS change_pct
FROM with_prev
ORDER BY month;

-- 3. Category ranking inside each region (RANK)
-- RANK() OVER (PARTITION BY region ...) restarts the ranking for every
-- region, so each region gets its own 1st, 2nd, 3rd... category.
WITH category_region AS (
    SELECT region,
           category,
           SUM(revenue) AS revenue
    FROM sales
    GROUP BY region, category
)
SELECT region,
       category,
       revenue,
       RANK() OVER (PARTITION BY region ORDER BY revenue DESC) AS rank_in_region
FROM category_region
ORDER BY region, rank_in_region;

-- 4. Top category per region
-- Same ranking as query 3, filtered down to rank 1 only.
WITH category_region AS (
    SELECT region,
           category,
           SUM(revenue) AS revenue,
           COUNT(*) AS orders
    FROM sales
    GROUP BY region, category
),
ranked AS (
    SELECT region,
           category,
           revenue,
           orders,
           RANK() OVER (PARTITION BY region ORDER BY revenue DESC) AS rank_in_region
    FROM category_region
)
SELECT region, category, revenue, orders
FROM ranked
WHERE rank_in_region = 1
ORDER BY revenue DESC;

-- 5. Three-month moving average of monthly revenue
-- The frame ROWS BETWEEN 2 PRECEDING AND CURRENT ROW averages each month
-- with the two months before it, which smooths out one-month spikes.
WITH monthly AS (
    SELECT strftime('%Y-%m', order_date) AS month,
           SUM(revenue) AS revenue
    FROM sales
    GROUP BY month
)
SELECT month,
       revenue,
       ROUND(AVG(revenue) OVER (
           ORDER BY month
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ), 2) AS moving_avg_3m
FROM monthly
ORDER BY month;

-- 6. Biggest orders and where they sit in the revenue distribution
-- PERCENT_RANK shows each order's position from 0 (smallest) to 1
-- (largest), so the top orders all sit at 0.99+.
SELECT order_id,
       order_date,
       category,
       region,
       revenue,
       ROUND(PERCENT_RANK() OVER (ORDER BY revenue), 3) AS revenue_percentile
FROM sales
ORDER BY revenue DESC
LIMIT 10;

-- 7. Top customers and their cumulative share of revenue (Pareto view)
-- Customers are ranked by total spend, then a running total over that
-- ranking shows how much of all revenue the top customers account for.
WITH customer_revenue AS (
    SELECT customer_id,
           COUNT(*) AS orders,
           SUM(revenue) AS total_spent
    FROM sales
    GROUP BY customer_id
),
ranked AS (
    SELECT customer_id,
           orders,
           total_spent,
           RANK() OVER (ORDER BY total_spent DESC) AS spend_rank,
           SUM(total_spent) OVER (ORDER BY total_spent DESC) AS cumulative_revenue,
           SUM(total_spent) OVER () AS grand_total
    FROM customer_revenue
)
SELECT customer_id,
       orders,
       total_spent,
       spend_rank,
       ROUND(100.0 * cumulative_revenue / grand_total, 1) AS cumulative_pct_of_revenue
FROM ranked
ORDER BY total_spent DESC
LIMIT 10;
