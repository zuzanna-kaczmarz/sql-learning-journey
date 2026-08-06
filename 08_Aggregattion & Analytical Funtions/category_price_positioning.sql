--**Business Question:** _Assign a rank to each product based on its price within its respective category to understand internal product hierarchy._
SELECT 
    ProductID,
	Product AS ProductName,
	Category,
	DENSE_RANK() OVER(PARTITION BY Category ORDER BY Price) AS RankInCategory
FROM Sales.Products;