# Findings — Retail Sales Analysis (synthetic practice data)

Dataset: 1,200 orders, Jan–Dec 2024, after cleaning 1210 raw rows → 1200 clean rows
(removed 10 duplicate rows, filled 25 missing regions, 15 missing discounts, standardised category casing).

## Headline numbers
- Total revenue: $118,568.75
- Unique orders: 1200
- Average order value: $98.81
- Total units sold: 2312

## By category
                  sum  count
category                    
Clothing     37046.85    303
Sports       29256.40    290
Electronics  28999.30    319
Home         23266.20    288

Top category: Clothing — $37,046.85 (31.2% of revenue)

## By region
region
West       30138.80
East       29484.00
South      28680.55
North      27703.15
Unknown     2562.25

## By channel
channel
In-Store    59286.50
Online      59282.25

## By month
Best month: 2024-11 — $14,948.60
Slowest month: 2024-05 — $7,335.45
Monthly revenue ranged $7,335.45–$14,948.60.

## Top 5 products by revenue
product
Sneakers               18534.50
Dumbbell Set           18186.00
Wireless Headphones    11494.50
Coffee Maker           10016.95
Jeans                   7871.50

## 3 takeaways
1. Clothing drives the most revenue — focus promotions and stock there first.
2. West is the strongest region ($30,138.80); investigate what works there and replicate it.
3. 2024-11 was the peak month — plan inventory and staffing ahead of that seasonal lift, not during it.

## Tools used
Python (pandas), SQL / MySQL, Microsoft Excel
