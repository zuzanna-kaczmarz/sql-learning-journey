-- Business Question: Find the cheapest and most expensive items in each category to understand our price variety.
SELECT 
    Product AS ProductName,
    Category,
    Price,
    MAX(Price) OVER (PARTITION BY Category) AS MaxCategoryPrice,
    MIN(Price) OVER (PARTITION BY Category) AS MinCategoryPrice
FROM Sales.Products;