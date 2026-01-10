# AdventureWorks SQL Analytics Portfolio

## 📌 Overview

This repository showcases a hands-on SQL analytics project built using Microsoft’s **AdventureWorks Data Warehouse (AdventureWorksDW)** sample database. The project is designed to demonstrate practical, interview-ready SQL skills commonly required for **Business Analyst / Data Analyst / Regional Operations** roles.

The focus is on:

* Understanding a real-world star schema
* Writing clean, well-structured SQL
* Answering clear business questions using data
* Applying advanced SQL concepts such as **CTEs**, **window functions**, and **ranking**

---

## 🗄️ Dataset

* **Database:** AdventureWorksDW
* **Source:** Microsoft Sample Database
* **Schema Type:** Star Schema
* **Fact Tables Used:**

  * `FactInternetSales`
* **Dimension Tables Used:**

  * `DimDate`
  * `DimProduct`
  * `DimProductSubcategory`
  * `DimProductCategory`
  * `DimCustomer`
  * `DimSalesTerritory`

---

## 🛠️ Tools & Environment

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* GitHub for version control and portfolio hosting

---

## 📊 Business Questions & Queries

### **Query 1: Top Products by Total Sales**

Identifies the best-performing products based on total Internet sales revenue.

**Skills demonstrated:**

* Aggregation (`SUM`)
* Joins between fact and dimension tables
* Sorting and filtering

---

### **Query 2: Monthly Sales Trend**

Analyzes how Internet sales revenue changes over time by month and year.

**Skills demonstrated:**

* Date dimension usage
* Time-based aggregation
* Trend analysis

---

### **Query 3: Top 10 Customers by Total Sales**

Finds the most valuable customers based on cumulative Internet sales.

**Skills demonstrated:**

* Customer-level aggregation
* Ranking and ordering

---

### **Query 4: Sales by Region (Country)**

Shows which sales territories generate the highest Internet sales revenue.

**Skills demonstrated:**

* Geographic analysis
* Fact-to-dimension joins

---

### **Query 5: Product Ranking Within Each Category**

Ranks products by total sales **within their respective product categories**.

**Skills demonstrated:**

* Common Table Expressions (CTEs)
* `RANK()` window function
* `PARTITION BY`

---

### **Query 6: Cumulative Monthly Sales (Running Total)**

Calculates cumulative Internet sales revenue month-by-month, resetting each year.

**Skills demonstrated:**

* Window functions (`SUM() OVER`)
* Running totals
* Time-series analysis

---

### **Query 7: Top 5 Customers per Country**

Identifies the top 5 customers in each country based on total Internet sales.

**Skills demonstrated:**

* Multi-level CTEs
* `RANK()` with partitioning
* Top-N per group logic

---

## 📁 Repository Structure

```
├── adventureworks_sql_analysis.sql   -- All queries with business context & comments
├── README.md                         -- Project overview and explanation
```

---

## 🚀 Key SQL Concepts Demonstrated

* Star schema understanding
* Fact & dimension joins
* Aggregations and grouping
* Subqueries and CTEs
* Window functions (`RANK`, `SUM OVER`)
* Business-oriented analytical thinking

---

## 🎯 Why This Project

This project was built as part of focused SQL skill development. It reflects a structured, real-world approach to SQL analytics and demonstrates readiness for on-the-job analysis tasks.

---

## 📬 Contact

**Author:** Tee Jing Ye

Feel free to connect or reach out for feedback or collaboration.

