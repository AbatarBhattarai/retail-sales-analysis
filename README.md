# Retail Sales Analysis

By Abatar Bhattarai — CIS student at East Texas A&M, graduating May 2027

I did this project to practice data analysis with Python, SQL, and Excel.

I cleaned a messy sales file in Python (pandas) — removed duplicates, filled missing values, and fixed the category names. Then I used SQL to look at revenue by category, region, and month, and made a summary in Excel.

## What I found
- Total revenue: $118,568.75 from 1,200 orders
- Average order: $98.81
- Top category: Clothing, $37,046.85 (31% of revenue)
- Top product: Sneakers, $18,534.50
- Best month: November 2024, $14,948.60

## Files
- `sales_data_raw.csv` — the messy data I started with
- `analysis.py` — my Python cleaning script
- `sales_data_clean.csv` — the cleaned data
- `queries.sql` — my 10 SQL queries
- `dashboard.xlsx` — my Excel summary
- `findings.md` — my findings

The data is practice data I made up for this project, not real store sales.

## Advanced SQL

After the basic queries in `queries.sql`, I wrote `queries-advanced.sql` to practice CTEs and window functions on the same data. Every query runs, and the top output of each one is in `queries-advanced-results.md`.

What the file covers:

- **Monthly running total** — a CTE rolls orders up by month, then `SUM() OVER` builds the cumulative revenue.
- **Month-over-month change** — `LAG` compares each month with the one before it. November 2024 jumped 73.2% over October.
- **Category ranking per region** — `RANK() OVER (PARTITION BY region ...)` ranks the categories inside each region separately.
- **Top category per region** — Clothing leads in the East and West; Electronics leads in the South and North.
- **3-month moving average** — a `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` frame smooths the monthly trend.
- **Biggest orders by percentile** — `PERCENT_RANK` places the largest orders (all Sports, $570–$600) at the 99.7th percentile.
- **Top customers, Pareto view** — spend is spread out: even the top 10 customers together are only 6.9% of revenue, so no single customer carries the store.
