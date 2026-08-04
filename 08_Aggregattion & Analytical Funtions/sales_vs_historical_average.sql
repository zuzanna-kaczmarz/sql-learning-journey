/*
Business Question

For each order, calculate the difference between its sales
value and the average sales of all previous orders for the
same product.

The current order should not be included in the average.
*/

SELECT
    o.OrderID,
    o.ProductID,
    o.Sales,
    o.OrderDate,

    COALESCE(
        AVG(o.Sales) OVER (
            PARTITION BY o.ProductID
            ORDER BY o.OrderDate
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND 1 PRECEDING
        ),
        0
    ) AS PriorAverageSales,

    o.Sales -
    AVG(o.Sales) OVER (
        PARTITION BY o.ProductID
        ORDER BY o.OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND 1 PRECEDING
    ) AS SalesDifference

FROM Sales.Orders AS o;