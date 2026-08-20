/* GOAL: Internal Compensation Benchmarking – Analyzing individual employee pay relative to departmental peer averages.
LOGIC: This script identifies pay deviations by calculating a dynamic baseline for each department. 
To ensure an unbiased group mean, the logic isolates peer data by programmatically excluding 
the current employee's own salary from their team's average calculation */

SELECT 
	e1.FirstName,
	e1.LastName,
	e1.Department,
	e1.Salary,
	(
		SELECT AVG(CAST(e2.Salary AS FLOAT))
		FROM Sales.Employees AS e2
		WHERE e2.Department = e1.Department
			AND e2.EmployeeID <> e1.EmployeeID
	)AS AvgDepartmentSalaryOthers,
	ROUND(
		CAST(e1.Salary AS FLOAT ) -(
		SELECT AVG(CAST(e2.Salary AS FLOAT))
		FROM Sales.Employees AS e2
		WHERE e2.Department =e1.Department
		AND e2.EmployeeID <> e1.EmployeeID
	),2
	)AS diff
FROM Sales.Employees AS e1
ORDER BY e1.Department, e1.Salary DESC;

		