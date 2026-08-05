-- Business Question: Calculate a 3-product moving average of prices to see stable price trends and smooth out individual fluctuations.
SELECT 
    ProductID,
    Product AS ProductName,
    Price,
    AVG(CAST(Price AS FLOAT)) OVER (
        ORDER BY ProductID 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAveragePrice
FROM Sales.Products;