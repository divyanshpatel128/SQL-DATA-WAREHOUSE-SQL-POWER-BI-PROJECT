# SQL-Data-Warehouse Project
Welcome to the **Data Warehouse Project** repository! 🚀
This project demonstrates a comprehensive data warehousing  solution, from building a data warehouse to generating actionable insights.

# POWER BI DASHBOARD

![Screenshot 2025-06-15 171433](https://github.com/user-attachments/assets/488ed616-1722-46e2-8495-283085b35179)
![Screenshot 2025-06-15 171448](https://github.com/user-attachments/assets/db1d030b-aef2-42c1-9b97-e3a4545d4b5f)

![Screenshot 2025-06-15 171504](https://github.com/user-attachments/assets/b45a8503-5bfb-4cd4-bc45-eae18e6e870a)


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
---
## Project Structure
| Layer               | Description                                                              | Link                                                                                                              |
| ------------------- | ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| 🟫 **Bronze Layer** | Raw data ingestion from CSV files (ERP and CRM)                          | [Browse Scripts 🔗](https://github.com/divyanshpatel128/SQL-DATA-WAREHOUSE-PROJECTS/tree/main/scripts/bronzer%20) |
| ⚪ **Silver Layer**  | Cleansing, transformation, normalization, and business logic integration | [Browse Scripts 🔗](https://github.com/divyanshpatel128/SQL-DATA-WAREHOUSE-PROJECTS/tree/main/scripts/silver)     |
| 🟨 **Gold Layer**   | Final reporting views using star schema for BI tools                     | [Browse Scripts 🔗](https://github.com/divyanshpatel128/SQL-DATA-WAREHOUSE-PROJECTS/tree/main/scripts/gold%20)    |


## 🎯 Skills Showcased

This project demonstrates skills in:

- SQL Development  
- Data Architecture  
- Data Engineering  
- ETL Pipeline Development  
- Data Modeling  

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

## 🙋‍♂️ Author

**Divyansh Patel**  
Aspiring Data Analyst | Passionate about SQL, BI Tools & Data Storytelling  
Connect with me on https://www.linkedin.com/in/divyansh-patel-dataanalyst/

