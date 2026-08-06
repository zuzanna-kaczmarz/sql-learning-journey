--Business Question: Identify the three highest-paid employees in each department to monitor budget allocation for top-tier talent.
SELECT 
	FirstName,
	LastName,
	SalaryInDepartmentRank
FROM(
	SELECT 
		FirstName,
		LastName,
		Department,
		Salary,
		RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS SalaryInDepartmentRank
	FROM Sales.Employees
	)AS t
WHERE SalaryInDepartmentRank <=3;
