-- Delivery & Returns Analysis — MySQL queries
-- Table: orders (order_id, category, region, shipping, delivery_days, order_value, returned)
-- 1. Overall return rate
SELECT COUNT(*) AS total_orders, SUM(returned='Yes') AS returned, ROUND(100*SUM(returned='Yes')/COUNT(*),1) AS return_rate_pct FROM orders;
-- 2. Return rate by category
SELECT category, COUNT(*) AS orders, ROUND(100*SUM(returned='Yes')/COUNT(*),1) AS return_rate_pct FROM orders GROUP BY category ORDER BY return_rate_pct DESC;
-- 3. Return rate by shipping method
SELECT shipping, COUNT(*) AS orders, ROUND(100*SUM(returned='Yes')/COUNT(*),1) AS return_rate_pct FROM orders GROUP BY shipping;
-- 4. Return rate by region
SELECT region, COUNT(*) AS orders, ROUND(100*SUM(returned='Yes')/COUNT(*),1) AS return_rate_pct FROM orders GROUP BY region ORDER BY return_rate_pct DESC;
-- 5. Average delivery days: returned vs kept
SELECT returned, ROUND(AVG(delivery_days),1) AS avg_delivery_days, ROUND(AVG(order_value),2) AS avg_order_value FROM orders GROUP BY returned;
-- 6. Late deliveries (6+ days) and their return rate
SELECT COUNT(*) AS late_orders, ROUND(100*SUM(returned='Yes')/COUNT(*),1) AS return_rate_pct FROM orders WHERE delivery_days>=6;
-- 7. Value lost to returns
SELECT ROUND(SUM(order_value),2) AS returned_order_value FROM orders WHERE returned='Yes';
-- 8. Highest-return group: Clothing, Standard shipping
SELECT COUNT(*) AS orders, ROUND(100*SUM(returned='Yes')/COUNT(*),1) AS return_rate_pct FROM orders WHERE category='Clothing' AND shipping='Standard';
