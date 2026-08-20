/*Retrieve a list of product names and categories that have never been ordered, but only for those categories that have at least one other product with a single sale exceeding $500.*/

SELECT 
	p.Product AS ProductName,
	p.Category
FROM Sales.Products AS p
WHERE NOT EXISTS (
		SELECT 1
		FROM Sales.Orders AS o
		WHERE o.ProductID = p.ProductID
		)
		AND p.Category IN (
			SELECT DISTINCT p2.Category 
			FROM Sales.Orders AS o2
			JOIN Sales.Products AS p2 ON o2.ProductID =p2.ProductID
			WHERE o2.Sales >500
	);
