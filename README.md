📦 Supply Chain Analytics Dashboard

An End-to-End Business Intelligence Solution using Python, SQL Server, and Power BI.

📖 Table of Contents
Project Overview
Business Problem
Objectives
Dataset Description
Project Architecture
Python Workflow
SQL Data Warehouse
Power BI Data Model
Dashboard Pages
Dashboard Screenshots
Key Business Insights
Technologies Used
Skills Demonstrated
Repository Structure
Future Enhancements
Resume Project Description
📌 Project Overview

This project presents an end-to-end Supply Chain Analytics solution developed using Python, SQL Server, and Power BI. The objective was to transform raw transactional supply chain data into meaningful business insights through data cleaning, data warehousing, advanced SQL analysis, and interactive Power BI dashboards.

The project follows a real-world Business Intelligence workflow, beginning with raw operational data and ending with an executive dashboard that supports business decision-making.

🎯 Business Problem

Supply chain companies generate millions of transactional records every year. While this data contains valuable business information, it is difficult to identify trends, customer behavior, product performance, and market opportunities directly from raw datasets.

Business stakeholders require answers to questions such as:

Which products generate the highest revenue and profit?
Which customers contribute the most sales?
Which markets perform the best?
Which product categories require improvement?
How are sales changing over time?
What are the Year-over-Year (YoY) trends?
How is business performing quarterly?

Without an analytical reporting system, answering these questions becomes time-consuming and inefficient.

This project solves these challenges by building a complete analytics solution using Python, SQL Server, and Power BI.

🎯 Project Objectives
Clean and preprocess raw supply chain data using Python
Perform feature engineering for business analysis
Design a Star Schema Data Warehouse
Build Fact and Dimension tables in SQL Server
Create SQL Views, Stored Procedures, and Indexes
Develop reusable DAX Measures
Create interactive Power BI dashboards
Perform Time Intelligence Analysis
Implement Drill-through navigation
Deliver actionable business insights
📊 Dataset Description

The dataset contains historical supply chain transaction data including customer information, product details, sales, shipping information, market data, and financial metrics.

Note: The full dataset is not included due to GitHub file size limitations. A representative sample dataset is provided for demonstration purposes.

Main Attributes
Customer Information
Customer ID
Customer Name
Customer Segment
Country
State
Product Information
Product Name
Category
Department
Order Information
Order Date
Shipping Date
Quantity
Delivery Status
Financial Information
Sales
Profit
Discount
Market Information
Market
Region
Feature Engineering

The following analytical columns were created using Python:

Order Year
Order Quarter
Order Month
Order Week
Shipping Delay
Shipping Performance
Profit Category
Price Category
🏗 Project Architecture
                    Raw Dataset
                         │
                         ▼
              Python Data Cleaning
          & Feature Engineering
                         │
                         ▼
          SQL Server Data Warehouse
               (Star Schema Model)
                         │
                         ▼
        Views | Stored Procedures
              Indexes | SQL Queries
                         │
                         ▼
            Power BI Data Modeling
                  + DAX Measures
                         │
                         ▼
          Interactive Business Dashboard

🐍 Python Workflow

The data preprocessing pipeline included:

Data Cleaning
Removed duplicate records
Removed unnecessary columns
Handled missing values
Converted data types
Standardized text values
Rounded numerical columns
Exploratory Data Analysis
Univariate Analysis
Bivariate Analysis
Correlation Analysis
Distribution Analysis
Outlier Detection
Feature Engineering

Created business-friendly analytical columns including:

Shipping Performance
Shipping Delay
Profit Category
Price Category
Order Year
Order Quarter
Order Month
Order Week
🗄 SQL Data Warehouse

A Star Schema Data Warehouse was designed consisting of:

Fact Table
Fact_Orders
Dimension Tables
Dim_Customer
Dim_Product
Dim_Category
Dim_Department
Dim_Date

Additional SQL implementations include:

Primary Keys
Foreign Keys
SQL Views
Clustered Indexes
Stored Procedures
Incremental Loading
📈 Power BI Data Model

The Power BI solution includes:

Star Schema Relationship Model
Date Table
DAX Measures
Time Intelligence
Drill-through
Sync Slicers
Interactive Filtering
KPI Cards

More than 30 DAX Measures were developed including:

Total Sales
Total Profit
Total Orders
Total Quantity
Sales Last Year
Sales YTD
Sales MTD
Previous Month Sales
YoY %
Profit Margin
Average Sales Per Customer
Product Rank
📊 Dashboard Pages
1️⃣ Executive Dashboard

Provides a high-level overview of business performance.

KPIs

Total Sales
Total Orders
Total Quantity
Total Profit
Sales Last Year
Profit Margin
YoY Growth

Visuals

Monthly Sales Trend
Top Categories by Orders
Profit vs Discount
Sales by Market
2️⃣ Customer Analytics

Provides customer purchasing insights.

Visuals include:

Top Customers by Sales
Top Customers by Profit
Average Sales per Customer by Market
Customer Performance Matrix
3️⃣ Product Analytics

Provides product and department performance analysis.

Visuals include:

Top Products by Sales
Top Categories by Profit
Department Orders
Product Performance Matrix
4️⃣ Sales Trends & Time Intelligence

Provides business trend analysis using DAX Time Intelligence.

Visuals include:

Current vs Previous Year Sales
MTD Sales
YTD Sales
Quarterly Sales Analysis
Time Intelligence Summary
5️⃣ Product Performance Details

Interactive Drill-through page displaying:

Product Sales
Product Profit
Product Quantity
Category Performance
Department Performance
📷 Dashboard Screenshots
Executive Dashboard
Customer Analytics
Product Analytics
Sales Trends & Time Intelligence
Product Performance Details
📌 Key Business Insights
Europe generated the highest sales among all markets.
Fishing products generated the highest overall profit.
Some high-selling products produced comparatively lower profits.
Customer profitability varies significantly across markets.
Sales demonstrate seasonal trends across different months.
Quarterly analysis reveals changing business performance throughout the year.
Product ranking helps identify high-performing and underperforming products.
🛠 Technologies Used
Technology	Purpose
Python	Data Cleaning & Feature Engineering
Pandas	Data Manipulation
NumPy	Numerical Computing
Matplotlib	Exploratory Data Analysis
SQL Server	Data Warehouse
T-SQL	Data Analysis
Power BI	Dashboard Development
DAX	Business Calculations
GitHub	Version Control
💡 Skills Demonstrated
Data Cleaning
Data Wrangling
Exploratory Data Analysis (EDA)
Feature Engineering
SQL Query Writing
Data Warehouse Design
Star Schema Modeling
SQL Views
Stored Procedures
Indexing
Incremental Loading
Power BI Data Modeling
DAX Measures
Time Intelligence
Drill-through Analysis
Interactive Dashboard Design
Business Intelligence Reporting
📂 Repository Structure
Supply-Chain-Analytics-Dashboard
│
├── Dataset
│   ├── Raw_Data.csv
│   └── Cleaned_Data.csv
│
├── Python
│   ├── Data_Cleaning.ipynb
│   └── Feature_Engineering.ipynb
│
├── SQL
│   ├── Create_Tables.sql
│   ├── Views.sql
│   ├── Stored_Procedures.sql
│   ├── Indexes.sql
│   └── Analytical_Queries.sql
│
├── Power BI
│   └── SupplyChainDashboard.pbix
│
├── Dashboard Screenshots
│   ├── Executive Dashboard.png
│   ├── Customer Analytics.png
│   ├── Product Analytics.png
│   ├── Sales Trends.png
│   └── Product Details.png
│
├── README.md
│
└── LICENSE

🚀 Future Enhancements
Deploy dashboard to Power BI Service
Implement Row-Level Security (RLS)
Add Forecasting Models
Build Automated ETL Pipeline
Enable Scheduled Data Refresh
Develop Mobile Dashboard Layout
📄 Resume Project Description

Supply Chain Analytics Dashboard | Python, SQL Server, Power BI, DAX

Developed an end-to-end Business Intelligence solution by cleaning and transforming supply chain data using Python, designing a Star Schema data warehouse in SQL Server, implementing SQL views, indexes, and stored procedures, and building an interactive 5-page Power BI dashboard with over 30 DAX measures, drill-through analysis, and time intelligence reporting to provide actionable business insights.

⭐ If you found this project helpful, feel free to star the repository! i need same in this format
