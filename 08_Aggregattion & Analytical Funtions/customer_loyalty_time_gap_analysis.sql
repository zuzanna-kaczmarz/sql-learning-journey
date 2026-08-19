/* 
BUSINESS QUESTION: What is the typical buying cycle for our customers?
ENGINEERING APPROACH: Measuring the time gap (in days) between consecutive orders for each customer using LEAD().
Transforming results into a user-friendly status report, identifying "Last Order" touchpoints.
*/

SELECT
    CustomerID,
    OrderID,
    OrderDate,
    NextOrderDate,
    CASE 
        WHEN DaysDiff IS NULL THEN 'Last order'
        ELSE CAST(DaysDiff AS VARCHAR(10))
    END AS DaysUntilNextPurchase
FROM (
    SELECT 
        CustomerID,
        OrderID,
        OrderDate,
        LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrderDate,
        DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysDiff
    FROM Sales.Orders
) AS OrderTimeline;