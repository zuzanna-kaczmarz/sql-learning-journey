
SELECT
    OrderID,
    ProductID,
    CustomerID,
    Sales,
    Quantity,
    AVG(CAST(Sales AS FLOAT)) OVER () AS GlobalAvgSales,
    AVG(CAST(Quantity AS FLOAT)) OVER () AS GlobalAvgQuantity
FROM Sales.Orders;