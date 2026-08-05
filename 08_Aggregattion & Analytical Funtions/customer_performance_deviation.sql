-- Business Question: How much more (or less) does each customer spend compared to the average customer?
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COALESCE(SUM(o.Sales) OVER (PARTITION BY c.CustomerID), 0) AS TotalCustomerSales,
    AVG(CAST(o.Sales AS FLOAT)) OVER () AS GlobalAvgSales,
    COALESCE(SUM(o.Sales) OVER (PARTITION BY c.CustomerID), 0) - AVG(CAST(o.Sales AS FLOAT)) OVER () AS SpendingDeviation
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o ON c.CustomerID = o.CustomerID;