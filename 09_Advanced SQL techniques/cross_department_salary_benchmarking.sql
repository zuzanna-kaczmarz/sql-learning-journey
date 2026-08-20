/* For every employee in the Sales.Employees table, display their FirstName, LastName, Department, and Salary. Additionally, include a column that calculates the average salary of all employees who belong to departments other than the one the current employee is assigned to.*/

SELECT 
	e1.FirstName,
	e1.LastName,
	e1.Department,
	e1.Salary,
	(SELECT 
		ROUND(AVG(CAST(e2.Salary AS FLOAT)),2) 
		FROM Sales.Employees AS e2
		WHERE e1.Department <> e2.Department
		)AS AvgSalaryOtherDepartments
FROM Sales.Employees AS e1;