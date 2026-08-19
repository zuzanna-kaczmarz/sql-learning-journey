/* 
BUSINESS QUESTION: How do our individual product prices compare against the entry-level (cheapest) options in each category?
ANALYTICAL APPROACH: Benchmarking each product against the minimum price in its segment using FIRST_VALUE().
This analysis helps identify premium-priced items and informs competitive pricing strategies.
*/

SELECT 
    ProductID,
    Product AS ProductName,
    Category,
    Price AS CurrentPrice,
    FIRST_VALUE(Product) OVER (
        PARTITION BY Category 
        ORDER BY Price ASC
    ) AS CheapestProductNameInCategory,
    FIRST_VALUE(Price) OVER (
        PARTITION BY Category 
        ORDER BY Price ASC
    ) AS MinimumCategoryPrice,
    Price - FIRST_VALUE(Price) OVER (
        PARTITION BY Category 
        ORDER BY Price ASC
    ) AS PriceGapFromEntryLevel
FROM Sales.Products;



