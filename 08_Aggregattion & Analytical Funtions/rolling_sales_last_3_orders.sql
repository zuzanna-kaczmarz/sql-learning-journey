/*
Business Question

For each order, display:

- OrderID
- CustomerID
- OrderDate
- Sales

Additionally, calculate a rolling sales total that includes
the current order and the two previous orders placed by the
same customer, ordered by OrderDate.
*/

SELECT
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    o.Sales,
    SUM(o.Sales) OVER (
        PARTITION BY o.CustomerID
        ORDER BY o.OrderDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS RollingSalesLast3Orders
FROM Sales.Orders AS o;