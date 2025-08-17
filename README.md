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
- 
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
```

### 🧮 DAX Measures
### Total Sales
DAX
Total Sales = SUM(Fact_Sales[total_price])
### Total Profit
DAX
Total Profit = SUM(Fact_Sales[total_price] - Fact_Sales[total_cost])
### Profit Margin (%)
DAX
Profit Margin (%) = DIVIDE([Total Profit], [Total Sales], 0) * 100
DAX
### Time Intelligent (PY & YoY%)
DAX
Total Sale PY = CALCULATE([Total Sale],SAMEPERIODLASTYEAR(date_table[date])) | Total Sale YoY% = DIVIDE([Total Sales] - [Total Sale PY], [Total Sale PY])

## 📊 Dashboard Features

- KPI Cards → Total Sales, Total Profit, Profit Margin %
- Trend Line → Monthly sales
- Country Performance Table → Sales, Profit, PY Sales, YoY growth with conditional formatting
- Category Breakdown → Donut chart + detailed category table
- Drill-through → Country-level analysis (monthly + product category breakdown)
- Best-Selling Product (Drill-through) → Highlights the top product by sales for the selected country
- Custom Tooltips → Product sales trend by month for the selected year

## 🖼️ Screenshots

Summary Page
<img width="971" height="546" alt="image" src="https://github.com/user-attachments/assets/91296a62-800d-429e-a535-e0498457f23b" />

Drill-through Page (Country Level)
<img width="972" height="551" alt="image" src="https://github.com/user-attachments/assets/2fd0e1a1-46c4-4a52-8031-36ed80a5d380" />

Best-Selling Product Highlight (Country Drill-through)
<img width="968" height="251" alt="image" src="https://github.com/user-attachments/assets/049b3162-aeed-42b3-85b0-f4a5ad41b155" />

Tooltip (Product Sales Trend)
<img width="964" height="541" alt="image" src="https://github.com/user-attachments/assets/70c50933-62fb-4bd7-b407-7ad45771e1b6" />

## 🚀 Key Learnings

- Built an end-to-end BI solution combining SQL + Power BI
- Applied star schema modeling for efficiency
- Designed an executive-first dashboard layout (KPI → Country → Category → Drill-through)
- Enhanced UX with drill-through + tooltips + best-selling product

## 🛠️ Tools & Technologies

- SQL (PostgreSQL) – Data preparation, table joins, date table generation
- Power BI – Data modeling, DAX measures, visualization
- Power Query – Data cleaning and transformations

## 📂 Repository Structure
├── SQL_Scripts/
│   ├── create_date_table.sql
│   ├── create_fact_sales.sql
│
├── PowerBI/
│   ├── Sales_Profit_Dashboard.pbix
│
├── screenshots/
│   ├── summary.png
│   ├── drillthrough.png
│   ├── bestseller.png
│   ├── tooltip.png
│
└── README.md

## 🔗 Live Dashboard 

👉 [https://app.powerbi.com/view?r=eyJrIjoiNTcxMjgzZTktMjI5ZC00ZDhmLThiMDgtZThhZTg2MjM3NjFmIiwidCI6IjJjNzYxZjM5LTJiNGEtNGJlOC05NmY1LWU3ZTI0YmIyMTU2NSIsImMiOjEwfQ%3D%3D]


## ✨ Author
👤 Hein Thiha Thu

