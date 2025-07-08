# Kultra Mega Stores (KMS) Inventory Analysis

## Case Scenario 1

1.	Which product category had the highest sales?

SELECT [Product_Category], CAST(SUM([Sales]) AS DECIMAL(18,2)) AS [Total_Sales]
FROM KMS_INVENTORY
GROUP BY [Product_Category]
ORDER BY [Total_Sales] DESC;
