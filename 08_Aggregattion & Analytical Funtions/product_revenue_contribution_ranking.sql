--Business Question:Rank products by their total revenue contribution and show only those that fall within the top 10% of our most expensive items.
SELECT 
	ProductName,
	TotalRevenue,
	CONCAT(ROUND(PricePercentile *100,2), '%') AS PricePercentile
	
FROM(
	SELECT 
		p.ProductID,
		SUM(COALESCE(o.Sales,0)) AS TotalRevenue,
		p.Product AS ProductName,
		p.Price,
		CUME_DIST() OVER(ORDER BY p.Price DESC)  AS PricePercentile
		RANK() OVER (ORDER BY SUM(COALESCE(o.Sales,0)) DESC) AS RevenueRank
	FROM Sales.Orders AS o
	RIGHT JOIN Sales.Products AS p
	ON o.ProductID = p.ProductID
	GROUP BY 
		p.ProductID, 
		p.Product, 
		p.Price
) AS ProductsMetrics
WHERE PricePercentile <=0.1;