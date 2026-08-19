/* 
BUSINESS QUESTION: Identify actual transitions in order statuses to detect logistics anomalies and eliminate redundant system updates.
ENGINEERING APPROACH: Implementing a state-change detection logic using LAG() to filter only records where OrderStatus 
differed from the previous entry, ensuring clean audit logs for process mining.
*/

SELECT
	OrderID,
	CreationTime,
	PreviousStatus,
	CurrentStatus
FROM 
	(SELECT 
		OrderID,
		OrderStatus AS CurrentStatus,
		CreationTime,
		LAG(OrderStatus) OVER(PARTITION BY OrderID ORDER BY CreationTime)AS PreviousStatus
	FROM Sales.OrdersArchive
	)AS t
WHERE CurrentStatus <> PreviousStatus