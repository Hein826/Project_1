# 📊 Sales & Profit Performance Dashboard  

## 📌 Project Overview  
This project demonstrates an **end-to-end Business Intelligence (BI) workflow** using **PostgreSQL + Power BI**.
The goal is to track Sales, Profit, and Profit Margin across regions, categories, and time using a public Kaggle dataset.

### Key features:
- Executive dashboard with KPIs and trends
- Drill-through analysis by country
- Tooltips showing product sales month-by-month for the selected year
- Star schema data model for optimized performance

## 🗂️ Data Sources  
- Kaggle dataset (Sales, Customers, Products, Stores, Exchange Rates)  
- PostgreSQL database for data storage and preprocessing  

## ⚙️ Data Preparation  
### Date Table (SQL)  
- Created using `generate_series()` to support time intelligence functions.  
- Date Table (SQL) → Created using generate_series() for time intelligence functions
- Fact Table (SQL) → Combined Sales, Products, and Exchange Rates to pre-calculate cost, price, and exchange-adjusted values
- Star Schema → Modeled in Power BI with fact and dimension tables

```sql
CREATE TABLE date_table AS
SELECT 
    d.date,
    EXTRACT(YEAR FROM d.date) AS year,
    EXTRACT(MONTH FROM d.date) AS month,
    EXTRACT(DAY FROM d.date) AS day,
    EXTRACT(DOW FROM d.date) AS weekday,
    TO_CHAR(d.date, 'Month') AS month_name
FROM (
    SELECT generate_series(
        (SELECT DATE_TRUNC('year', MIN(orderdate)) FROM sales),
        (SELECT DATE_TRUNC('year', MAX(orderdate)) + INTERVAL '1 year - 1 day' FROM sales),
        INTERVAL '1 day'
    )::date AS date
) AS d;

