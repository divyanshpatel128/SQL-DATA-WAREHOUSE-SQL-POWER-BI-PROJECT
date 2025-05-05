# SQL-Data-Warehouse-EDA-Advanced-Analytics-Power-BI Project
Welcome to the **Data Warehouse and Analytics Project** repository! 🚀
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

🏗️ Data Architecture
The data architecture for this project follows Medallion Architecture Bronze, Silver, and Gold layers:

![image](https://github.com/user-attachments/assets/82ef1cee-b66d-4c06-88f8-7b1059e653a0)

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV files into SQL Server Database.  
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.  
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.  


## 📖 Project Overview

This project includes the following components:

1. **Data Architecture**: Modern warehouse design using Bronze, Silver, and Gold layers.  
2. **ETL Pipelines**: Extract, Transform, Load processes to move data from source systems into the data warehouse.  
3. **Data Modeling**: Creation of fact and dimension tables for analytical workloads.  
4. **Analytics & Reporting**: SQL-based reports and dashboards for business insights.
5. **POWER BI REPORT** : created a live power bi report connect to sql server.


---

## 🎯 Skills Showcased

This project demonstrates skills in:

- SQL Development  
- Data Architecture  
- Data Engineering  
- ETL Pipeline Development  
- Data Modeling  
- Data Analytics

## 🚀 Project Requirements
Building the Data Warehouse (Data Engineering)
Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

Specifications
- Data Sources: Import data from two source systems (ERP and CRM) provided as CSV files.
- Data Quality: Cleanse and resolve data quality issues prior to analysis.
- Integration: Combine both sources into a single, user-friendly data model designed for analytical queries.
- Scope: Focus on the latest dataset only; historization of data is not required.
- Documentation: Provide clear documentation of the data model to support both business stakeholders and analytics teams.
