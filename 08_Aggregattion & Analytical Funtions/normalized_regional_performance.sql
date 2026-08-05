-- Business Question: Find the average customer score by country, treating missing scores as zero for a conservative and standardized regional audit.
SELECT 
    Country,
    AvgScoreNormalized
FROM (
    SELECT 
        Country,
        AVG(CAST(COALESCE(Score, 0) AS FLOAT)) OVER (PARTITION BY Country) AS AvgScoreNormalized,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY CustomerID) AS CountryRank
    FROM Sales.Customers
) AS RegionalStats
WHERE CountryRank = 1;