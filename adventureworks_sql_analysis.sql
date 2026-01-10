/*
Project: AdventureWorksDW SQL Analytics Portfolio
Author: Tee Jing Ye
Database: AdventureWorksDW
Description:
This project demonstrates SQL analytics using a star-schema data warehouse,
focusing on product sales performance and business insights.
*/

-- =========================================================
-- QUERY 1: TOP 10 PRODUCTS BY INTERNET SALES
-- Business Question:
-- Which products generate the highest revenue from online sales?
-- =========================================================

SELECT TOP 10
    p.EnglishProductName AS ProductName,
    SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales f
JOIN DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
ORDER BY TotalSales DESC;

-- =========================================================
-- QUERY 2: MONTHLY INTERNET SALES TREND
-- Business Question:
-- How does total Internet sales revenue trend over time by month?
-- =========================================================

SELECT
    d.CalendarYear,
    d.MonthNumberOfYear AS Month,
    d.EnglishMonthName,
    SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales f
JOIN DimDate d
    ON f.OrderDateKey = d.DateKey
GROUP BY
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.EnglishMonthName
ORDER BY
    d.CalendarYear,
    d.MonthNumberOfYear;

-- =========================================================
-- QUERY 3: TOP 10 CUSTOMERS BY INTERNET SALES
-- Business Question:
-- Which customers spend the most on Internet sales?
-- =========================================================

SELECT TOP 10
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales f
JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.FirstName,
    c.LastName
ORDER BY
    TotalSales DESC;

-- =========================================================
-- QUERY 4: INTERNET SALES BY COUNTRY
-- Business Question:
-- How much Internet sales revenue comes from each sales territory (country)?
-- =========================================================

SELECT 
    t.SalesTerritoryCountry,
    SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales f
JOIN DimSalesTerritory t
    ON f.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY
    t.SalesTerritoryCountry
ORDER BY
    TotalSales DESC;

-- =========================================================
-- QUERY 5: TOP PRODUCTS BY CATEGORY (WITH RANKING)
-- Business Question:
-- Within each product category, rank products by total Internet sales.
-- =========================================================

WITH ProductSales AS (
    SELECT
        c.EnglishProductCategoryName AS Category,
        p.EnglishProductName AS ProductName,
        SUM(f.SalesAmount) AS TotalSales
    FROM FactInternetSales f
    JOIN DimProduct p
        ON f.ProductKey = p.ProductKey
    JOIN DimProductSubcategory s
        ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
    JOIN DimProductCategory c
        ON s.ProductCategoryKey = c.ProductCategoryKey
    GROUP BY
        c.EnglishProductCategoryName,
        p.EnglishProductName
)
SELECT
    Category,
    ProductName,
    TotalSales,
    RANK() OVER (PARTITION BY Category ORDER BY TotalSales DESC) AS RankInCategory
FROM ProductSales
ORDER BY
    Category,
    RankInCategory;

-- =========================================================
-- QUERY 6: CUMULATIVE MONTHLY INTERNET SALES
-- Business Question:
-- How does Internet sales revenue accumulate over time?
-- =========================================================

WITH RunningSales AS (
    SELECT
        d.CalendarYear AS Year,
        d.MonthNumberOfYear AS MonthNumber,
        d.EnglishMonthName AS Month,
        SUM(f.SalesAmount) AS TotalSales
    FROM FactInternetSales f
    JOIN DimDate d
        ON f.OrderDateKey = d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear,
        d.EnglishMonthName
)
SELECT
    Year,
    MonthNumber,
    Month,
    SUM(TotalSales) OVER (
        PARTITION BY Year
        ORDER BY MonthNumber
    ) AS CumulativeTotal
FROM RunningSales
ORDER BY
    Year,
    MonthNumber;

-- =========================================================
-- Query 7: TOP 5 INTERNET CUSTOMERS PER COUNTRY
-- Business Question:
-- Which customers spend the most on Internet sales in each country?
-- =========================================================

WITH CustomerSales AS (
    SELECT
        c.FirstName + ' ' + c.LastName AS CustomerName,
        t.SalesTerritoryCountry AS Country,
        SUM(f.SalesAmount) AS TotalSales
    FROM FactInternetSales f
    JOIN DimCustomer c
        ON f.CustomerKey = c.CustomerKey
    JOIN DimSalesTerritory t
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
    GROUP BY
        c.FirstName,
        c.LastName,
        t.SalesTerritoryCountry
),
RankedCustomers AS (
    SELECT
        CustomerName,
        Country,
        TotalSales,
        RANK() OVER (
            PARTITION BY Country
            ORDER BY TotalSales DESC
        ) AS RankInCountry
    FROM CustomerSales
)
SELECT
    CustomerName,
    Country,
    TotalSales,
    RankInCountry
FROM RankedCustomers
WHERE RankInCountry <= 5
ORDER BY
    Country,
    RankInCountry;
