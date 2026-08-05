-- Business Question: Identify and list all employees who earn more than the average salary within their specific department to support performance reviews.
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary,
    DeptAvgSalary
FROM (
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        Salary,
        AVG(CAST(Salary AS FLOAT)) OVER (PARTITION BY Department) AS DeptAvgSalary
    FROM Sales.Employees
) AS SalaryAudit
WHERE Salary > DeptAvgSalary;