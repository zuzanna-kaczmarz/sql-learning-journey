-- Business Question: Detect and list only the redundant records in the archive to ensure data integrity and prepare for cleansing.
SELECT 
    OrderID,
    OrderDate,
    CustomerID,
    Sales
FROM (
    SELECT 
        OrderID,
        OrderDate,
        CustomerID,
        Sales,
        ROW_NUMBER() OVER (
            PARTITION BY OrderID 
            ORDER BY OrderID
        ) AS DuplicateRank
    FROM Sales.OrdersArchive 
) AS ArchiveAudit
WHERE DuplicateRank > 1;