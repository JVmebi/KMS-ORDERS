-- KMS Inventory Analysis
-- Author: Your Name
-- Date: July 2025

--CREATE DATABASE--

CREATE DATABASE KMS_DB


--CREATE TABLE--

CREATE TABLE KMS_ORDERS (
Row_ID INT,
Order_ID INT,
Order_Date DATE,
Order_Priority NVARCHAR(50),
Order_Quantity INT,
Sales DECIMAL(10,2),
Discount DECIMAL(4,2),
Ship_Mode NVARCHAR(50),
Profit DECIMAL(10,2),
Unit_Price DECIMAL(10,2),
Shipping_Cost DECIMAL(10,2),
Customer_Name NVARCHAR(50),
Province NVARCHAR(50),
Region NVARCHAR(50),
Customer_Segment NVARCHAR(50),
Product_Category NVARCHAR(50),
Product_Sub_Category NVARCHAR(100),
Product_Name NVARCHAR(100),
Product_Container NVARCHAR(50),
Product_Base_Margin DECIMAL(4,2),
Ship_Date DATE
);


CREATE TABLE Order_Status (
Order_ID INT,
Status NVARCHAR(50)
);
	

---CASE SCENARIO 1---

--- Q1: Which product category had the highest  sales?---
SELECT TOP 1 [Product_Category], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
GROUP BY [Product_Category]
ORDER BY [Total_Sales] DESC;
	   

--- Q2: What are the Top 3 and Bottom 3 regions in terms of sales?---
--- Top 3 regions in terms of sales ---
SELECT TOP 3 [Region], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total Sales]
FROM [KMS_INVENTORY]
GROUP BY Region
ORDER BY [Total Sales] desc

--- Bottom 3 regions in terms of sales ---
SELECT TOP 3 [Region], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
GROUP BY [REGION]
ORDER BY [Total_Sales] asc


--- Q3: What were the total sales of appliances in Ontario?---
SELECT Region, CAST(SUM(sales) AS DECIMAL(18,2)) AS [Total Sales]
FROM KMS_INVENTORY
WHERE Region='Ontario' AND Product_Category= 'Appliances'
GROUP BY Region


------- Q4: Revenue from Bottom 10 customers-----
SELECT TOP 10 [Customer_Name], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total Sales]
FROM KMS_INVENTORY
GROUP BY Customer_Name
ORDER BY [Total Sales] asc

----Checked Customer Buying Habits----
SELECT Customer_Name,
COUNT(DISTINCT Order_ID) AS Total_Orders,
SUM(Order_Quantity) AS Total_Quantity_Purchased,
AVG(Order_Quantity) AS Avg_Quantity_per_Order,
SUM(Sales) AS Total_Sales,
MAX(Product_Name) AS Regular_Product
FROM KMS_INVENTORY
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;

------- Q5: KMS incurred the most shipping cost using which shipping method?------
SELECT TOP 1 [Ship_Mode], CAST(SUM([Shipping_Cost]) AS DECIMAL(18,2)) AS [Total Shipping Cost]
FROM KMS_INVENTORY
GROUP BY Ship_Mode
ORDER BY [Total Shipping Cost] desc


---CASE SCENARIO 2---
------ Q6: Who are the most valuable customer, and what products or services did they typically purchase?------
SELECT [Customer_Name],Product_Name, CAST(SUM(Sales) AS DECIMAL(18,2)) AS [Total Sales]
FROM KMS_INVENTORY
GROUP BY Customer_Name,Product_Name
ORDER BY [Total Sales] desc


-------Q7: Which small business customer has the highest sales?-------
SELECT TOP 1 Customer_Name,Customer_Segment, CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total Sales]
FROM KMS_INVENTORY
WHERE Customer_Segment ='Small Business'
GROUP BY Customer_Name,Customer_Segment
ORDER BY [Total Sales] desc


-----Q8: Which corporate customer placed the most number of orders in 2019 -2012?------
SELECT TOP 1  Customer_Name,Customer_Segment, COUNT([Order_ID]) AS [Total order]
FROM KMS_INVENTORY
WHERE Customer_Segment ='Corporate' and Order_Date between '2009' and '2012'
GROUP BY Customer_Name,Customer_Segment
ORDER BY [Total order] desc


------Q9: Which consumer customer was the most profitable one?------
SELECT TOP 1 Customer_Name,Customer_Segment, CAST(SUM([Profit]) AS DECIMAL(18,2)) AS [Total profit]
FROM KMS_INVENTORY
WHERE Customer_Segment ='Consumer'
GROUP BY Customer_Name,Customer_Segment
ORDER BY [Total profit] desc


-------Q10: Which customer returned items, and what segments do they belong to?------
SELECT DISTINCT Customer_Name, Customer_Segment,[Status]
FROM KMS_INVENTORY
JOIN [Order_Status_Import1] ON KMS_INVENTORY . [Order_ID] = [Order_Status_Import1] . [Order_ID]
WHERE [Order_Status_Import1] . Status = 'Returned'
ORDER BY Customer_Name


--------Q11: Analyse shipping costs vs ship mode based on order priority------
SELECT Order_Priority, Ship_Mode,
COUNT(Order_ID) AS Order_Count,
SUM(Sales - Profit) AS Estimated_Shipping_Cost,
AVG(DATEDIFF(DAY, Order_Date, Ship_Date)) AS AVERAGE_SHIP_DATE
FROM KMS_INVENTORY
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, Ship_Mode desc;




