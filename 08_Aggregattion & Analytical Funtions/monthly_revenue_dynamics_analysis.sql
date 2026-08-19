/* 
BUSINESS QUESTION: How does our revenue evolve month-over-month (MoM)?
ANALYTICAL APPROACH: Calculating total monthly sales and using the LAG() window function 
to determine absolute and percentage growth/decline compared to the previous period.
Includes safety checks for division by zero using NULLIF().
*/

SELECT
    OrderMonth,
    CurrentMonthSales,
    PreviousMonthSales,
    (CurrentMonthSales - PreviousMonthSales) AS AbsoluteRevenueChange,
    CONCAT(
        ROUND(
            (CAST(CurrentMonthSales - PreviousMonthSales AS FLOAT) / NULLIF(PreviousMonthSales, 0)) * 100, 
            2
        ), 
        '%'
    ) AS MoM_PercentageChange
FROM (
    SELECT 
        MONTH(OrderDate) AS OrderMonth,
        SUM(Sales) AS CurrentMonthSales,
        LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) AS PreviousMonthSales
    FROM Sales.Orders
    GROUP BY MONTH(OrderDate)
) AS MonthlyMetrics;