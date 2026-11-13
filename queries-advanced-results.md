# Advanced SQL — Results

Every query in `queries-advanced.sql` was run against the cleaned retail dataset (`sales_data_clean.csv`, 1,200 orders, $118,568.75 total revenue). Below is the actual top output of each query.

## 1. Monthly revenue with a running total

| month | revenue | orders | running_total_revenue |
| --- | --- | --- | --- |
| 2024-01 | 8,931.85 | 101 | 8,931.85 |
| 2024-02 | 8,685.00 | 95 | 17,616.85 |
| 2024-03 | 10,670.25 | 113 | 28,287.10 |
| 2024-04 | 7,517.85 | 84 | 35,804.95 |
| 2024-05 | 7,335.45 | 89 | 43,140.40 |
| 2024-06 | 8,241.60 | 99 | 51,382.00 |
| 2024-07 | 9,402.45 | 113 | 60,784.45 |
| 2024-08 | 12,846.65 | 116 | 73,631.10 |
| 2024-09 | 8,198.45 | 86 | 81,829.55 |
| 2024-10 | 8,630.90 | 97 | 90,460.45 |
| 2024-11 | 14,948.60 | 105 | 105,409.05 |
| 2024-12 | 13,159.70 | 102 | 118,568.75 |

## 2. Month-over-month revenue change with LAG

| month | revenue | prev_month_revenue | change_amount | change_pct |
| --- | --- | --- | --- | --- |
| 2024-01 | 8,931.85 | None | None | None |
| 2024-02 | 8,685.00 | 8,931.85 | -246.85 | -2.8 |
| 2024-03 | 10,670.25 | 8,685.00 | 1,985.25 | 22.9 |
| 2024-04 | 7,517.85 | 10,670.25 | -3,152.40 | -29.5 |
| 2024-05 | 7,335.45 | 7,517.85 | -182.40 | -2.4 |
| 2024-06 | 8,241.60 | 7,335.45 | 906.15 | 12.4 |
| 2024-07 | 9,402.45 | 8,241.60 | 1,160.85 | 14.1 |
| 2024-08 | 12,846.65 | 9,402.45 | 3,444.20 | 36.6 |
| 2024-09 | 8,198.45 | 12,846.65 | -4,648.20 | -36.2 |
| 2024-10 | 8,630.90 | 8,198.45 | 432.45 | 5.3 |
| 2024-11 | 14,948.60 | 8,630.90 | 6,317.70 | 73.2 |
| 2024-12 | 13,159.70 | 14,948.60 | -1,788.90 | -12 |

## 3. Category ranking inside each region (RANK)

| region | category | revenue | rank_in_region |
| --- | --- | --- | --- |
| East | Clothing | 11,047.90 | 1 |
| East | Home | 6,285.25 | 2 |
| East | Sports | 6,248.90 | 3 |
| East | Electronics | 5,901.95 | 4 |
| North | Electronics | 7,894.50 | 1 |
| North | Sports | 7,481.80 | 2 |
| North | Clothing | 6,744.70 | 3 |
| North | Home | 5,582.15 | 4 |
| South | Electronics | 8,200.60 | 1 |
| South | Clothing | 8,031.00 | 2 |
| South | Sports | 7,598.30 | 3 |
| South | Home | 4,850.65 | 4 |

*(20 rows total — first 12 shown)*

## 4. Top category per region

| region | category | revenue | orders |
| --- | --- | --- | --- |
| East | Clothing | 11,047.90 | 76 |
| West | Clothing | 9,689.10 | 81 |
| South | Electronics | 8,200.60 | 78 |
| North | Electronics | 7,894.50 | 89 |
| Unknown | Clothing | 1,534.15 | 12 |

## 5. Three-month moving average of monthly revenue

| month | revenue | moving_avg_3m |
| --- | --- | --- |
| 2024-01 | 8,931.85 | 8,931.85 |
| 2024-02 | 8,685.00 | 8,808.42 |
| 2024-03 | 10,670.25 | 9,429.03 |
| 2024-04 | 7,517.85 | 8,957.70 |
| 2024-05 | 7,335.45 | 8,507.85 |
| 2024-06 | 8,241.60 | 7,698.30 |
| 2024-07 | 9,402.45 | 8,326.50 |
| 2024-08 | 12,846.65 | 10,163.57 |
| 2024-09 | 8,198.45 | 10,149.18 |
| 2024-10 | 8,630.90 | 9,892.00 |
| 2024-11 | 14,948.60 | 10,592.65 |
| 2024-12 | 13,159.70 | 12,246.40 |

## 6. Biggest orders and where they sit in the revenue distribution

| order_id | order_date | category | region | revenue | revenue_percentile |
| --- | --- | --- | --- | --- | --- |
| ORD-1510 | 2024-03-14 | Sports | East | 600.00 | 0.997 |
| ORD-1830 | 2024-08-07 | Sports | North | 600.00 | 0.997 |
| ORD-1316 | 2024-08-08 | Sports | North | 600.00 | 0.997 |
| ORD-1544 | 2024-10-22 | Sports | West | 600.00 | 0.997 |
| ORD-1010 | 2024-11-23 | Sports | South | 570.00 | 0.997 |
| ORD-1255 | 2024-01-04 | Sports | South | 480.00 | 0.994 |
| ORD-1187 | 2024-07-31 | Sports | East | 480.00 | 0.994 |
| ORD-1031 | 2024-08-20 | Sports | West | 480.00 | 0.994 |
| ORD-2158 | 2024-01-05 | Clothing | East | 475.00 | 0.987 |
| ORD-1809 | 2024-02-04 | Clothing | East | 475.00 | 0.987 |

## 7. Top customers and their cumulative share of revenue (Pareto view)

| customer_id | orders | total_spent | spend_rank | cumulative_pct_of_revenue |
| --- | --- | --- | --- | --- |
| CUST-279 | 5 | 1,055.35 | 1 | 0.9 |
| CUST-327 | 4 | 1,006.00 | 2 | 1.7 |
| CUST-192 | 6 | 983.55 | 3 | 2.6 |
| CUST-666 | 5 | 945.25 | 4 | 3.4 |
| CUST-886 | 3 | 790.00 | 5 | 4 |
| CUST-450 | 3 | 706.00 | 6 | 4.6 |
| CUST-795 | 2 | 698.00 | 7 | 5.2 |
| CUST-608 | 4 | 697.50 | 8 | 5.8 |
| CUST-265 | 4 | 684.00 | 9 | 6.4 |
| CUST-329 | 3 | 665.25 | 10 | 6.9 |
