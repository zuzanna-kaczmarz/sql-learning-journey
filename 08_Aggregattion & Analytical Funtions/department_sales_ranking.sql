/*
Business Question

Create a report showing:

- EmployeeID
- FirstName
- LastName
- Department

Rank each salesperson within their department based on
their total sales.

Salespeople with the same total sales should receive the
same rank, without leaving gaps in the ranking.
*/

SELECT
    o.SalesPersonID,
    e.FirstName,
    e.LastName,
    e.Department,
    SUM(o.Sales) AS TotalSales,

    DENSE_RANK() OVER (
        PARTITION BY e.Department
        ORDER BY SUM(o.Sales) DESC
    ) AS DepartmentRank

FROM Sales.Orders AS o

LEFT JOIN Sales.Employees AS e
    ON e.EmployeeID = o.SalesPersonID

GROUP BY
    o.SalesPersonID,
    e.FirstName,
    e.LastName,
    e.Department;