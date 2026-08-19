/* 
BUSINESS QUESTION: Does the first product category purchased by a customer determine their future spending patterns?
ANALYTICAL APPROACH: Identifying the initial touchpoint in the customer lifecycle and calculating the contribution of each 
transaction to the total customer lifetime value (LTV) using FIRST_VALUE() and Window Aggregates (Part-to-Whole analysis).
*/
SELECT 
    o.CustomerID,
    o.OrderID,
    o.OrderDate,
    p.Category AS CurrentCategory,
    FIRST_VALUE(p.Category) OVER (
        PARTITION BY o.CustomerID 
        ORDER BY o.OrderDate
    ) AS FirstBoughtCategory,
    o.Sales AS CurrentOrderSales,
    CONCAT(
        ROUND(
        (CAST(o.Sales AS FLOAT) / NULLIF(SUM(o.Sales) OVER (PARTITION BY o.CustomerID), 0)) * 100, 2), '%'
    ) AS PercentageOfTotalSpending
FROM Sales.Orders AS o
JOIN Sales.Products AS p ON o.ProductID = p.ProductID;