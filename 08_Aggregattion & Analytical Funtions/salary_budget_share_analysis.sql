-- Business Question: Calculate what percentage of the total company budget goes to each employee.
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    SUM(Salary) OVER () AS TotalPayroll,
    CONCAT(ROUND(CAST(Salary AS FLOAT) / SUM(Salary) OVER () * 100, 2), '%') AS SalarySharePercentage
FROM Sales.Employees;