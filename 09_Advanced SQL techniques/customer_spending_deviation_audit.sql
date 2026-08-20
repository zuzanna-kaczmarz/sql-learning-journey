/*For each record in the Sales.Orders table, display the OrderID, CustomerID, Sales, and OrderDate. Add a calculated column showing the difference between the current order's sales amount and the average sales of all previous orders placed by that specific customer (orders with an OrderDate earlier than the current one).*/

SELECT 
	o1.OrderID,
	o1.CustomerID,
	o1.Sales AS CurrentOrderSales,
	o1.OrderDate,
	ROUND(
		CAST(o1.Sales AS FLOAT) - (SELECT 
			AVG(CAST(Sales AS FLOAT))
		FROM Sales.Orders AS o2
		WHERE o2.CustomerID = o1.CustomerID
		AND o2.OrderDate < o1.OrderDate
		),2
	)AS DeviationFromPreviosSales
FROM Sales.Orders AS o1
ORDER BY o1.CustomerID, o1.OrderDate;




