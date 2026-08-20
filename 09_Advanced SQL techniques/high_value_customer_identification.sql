/* Identify customers (FirstName, LastName) who have placed at least one order with a sales amount higher than the average price of the top 10% most expensive products available in the database.*/

SELECT DISTINCT
	c.FirstName,
	c.LastName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.Sales > (
		SELECT 
			AVG(CAST(Price AS FLOAT))
		FROM(
			SELECT 
				ProductID,
				Price,
				NTILE(10) OVER (ORDER BY Price DESC) AS PriceTier
			FROM Sales.Products
		)AS ProductsRanked
		WHERE PriceTier =1
		)
		