"""Retail Sales Analysis — Abatar Bhattarai
Clean a messy CSV with pandas, then summarise revenue by category, region, channel and month.
Run:  python analysis.py
Input: sales_data_raw.csv   Output: sales_data_clean.csv + printed summary
"""
import pandas as pd

df = pd.read_csv("sales_data_raw.csv")
print(f"Raw rows: {len(df)}")

# 1. Remove duplicates
df = df.drop_duplicates()
# 2. Fill missing values
df["region"] = df["region"].fillna("Unknown")
df["discount"] = df["discount"].fillna(0)
# 3. Standardise text
df["category"] = df["category"].str.title()
# 4. Fix types and recompute revenue
df["order_date"] = pd.to_datetime(df["order_date"])
df["revenue"] = (df["unit_price"] * df["quantity"] * (1 - df["discount"])).round(2)
df = df.sort_values("order_date")

df.to_csv("sales_data_clean.csv", index=False)
print(f"Clean rows: {len(df)}")
print(f"Total revenue: ${df['revenue'].sum():,.2f}")
print(f"Average order value: ${df.groupby('order_id')['revenue'].sum().mean():.2f}")
print("\nRevenue by category:\n", df.groupby("category")["revenue"].sum().sort_values(ascending=False))
print("\nRevenue by region:\n", df.groupby("region")["revenue"].sum().sort_values(ascending=False))
print("\nRevenue by month:\n", df.groupby(df["order_date"].dt.to_period("M"))["revenue"].sum())
