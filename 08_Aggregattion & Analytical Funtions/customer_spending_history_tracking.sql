-- Business Question: Show each customer's orders over time with a running total of their spending.
SELECT 
    CustomerID,
    OrderDate,
    OrderID,
    Sales,
    SUM(Sales) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeSalesPerCustomer
FROM Sales.Orders;