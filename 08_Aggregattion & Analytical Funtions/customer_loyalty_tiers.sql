--Business Question: Divide our entire customer base into 4 equal segments (Tiers) based on their total spending to tailor marketing campaigns.
SELECT 
	FirstName,
	LastName,
	SumOfSales,
	CASE 
		WHEN Tier =1 THEN 'Platinum'
		WHEN Tier =2 THEN 'Gold'
		WHEN Tier =3 THEN 'Silver'
		WHEN Tier =4 THEN 'Bronze'
	END AS LoyaltyTier
FROM (
	SELECT 
		c.CustomerID,
		c.FirstName,
		c.LastName,
		COALESCE(SUM(o.Sales),0) AS SumOfSales,
		NTILE(4) OVER ( ORDER BY COALESCE(SUM(o.Sales),0) DESC) AS Tier
	FROM Sales.Customers AS c
	LEFT JOIN Sales.Orders AS o
	ON o.CustomerID = c.CustomerID  
	GROUP BY 
		c.CustomerID,
		c.FirstName,
		c.LastName
)AS t;