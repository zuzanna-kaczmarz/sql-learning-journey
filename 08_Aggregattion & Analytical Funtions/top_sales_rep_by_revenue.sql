--**Business Question:** _Identify the top-performing salesperson (by total revenue generated) for each month.
SELECT 
	FirstName,
	LastName,
	Rank,
	SalesSum
FROM(
	SELECT 
		e.FirstName,
		e.LastName,
		MONTH(o.OrderDate) AS Month,
		SUM(Sales) AS SalesSum,
		ROW_NUMBER() OVER(PARTITION BY MONTH(o.OrderDate) ORDER BY SUM(Sales) DESC) AS Rank
	FROM Sales.Orders AS o
	LEFT JOIN Sales.Employees AS e
	ON e.EmployeeID = o.SalesPersonID
	GROUP BY 
		e.EmployeeID,
		e.FirstName,
		e.LastName,
		MONTH(o.OrderDate)
)AS t
WHERE Rank=1
ORDER BY 
		Month ASC,
		SalesSum DESC;