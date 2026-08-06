--Business Question:** _Detect duplicate Order IDs in the archive and flag only the most recent version of each record based on CreationTime.
SELECT 
	OrderID,
	ValidityTag,
	CreationTime
FROM(
	SELECT 
		OrderID,
		ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY CreationTime DESC) AS ValidityTag,
		CreationTime
	FROM Sales.OrdersArchive
)AS t
WHERE ValidityTag =1;