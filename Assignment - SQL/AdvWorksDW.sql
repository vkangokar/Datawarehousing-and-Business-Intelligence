-- 1. What are the sales, product costs, profit, number of orders & quantity ordered for internet sales by product category and ranked by sales?
select format(sum(SalesAmount),'c','EN-US') as Sales,  Format(sum(ProductStandardCost),'c','EN-US') as Product_Costs, Format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit, sum(OrderQuantity) as Quantity_Ordered, count(SalesOrderNumber) as Number_of_Orders, DimPC.ProductCategoryKey, Rank() over(order by sum(SalesAmount)) as Rank_Product  from dbo.FactInternetSales as FIS
INNER JOIN dbo.DimProduct as DimP on FIS.ProductKey = DimP.ProductKey
INNER JOIN dbo.DimProductSubCategory as DimPSC on DimP.ProductSubcategoryKey = DimPSC.ProductSubcategoryKey
INNER JOIN dbo.DimProductCategory as DimPC on DimPSC.ProductCategoryKey = DimPC.ProductCategoryKey
group by DimPC.ProductCategoryKey;

-- 2. What are the sales, product costs, profit, number of orders & quantity ordered for reseller sales by product category and ranked by sales?
select format(sum(SalesAmount),'c','EN-US') as Sales,  
Format(sum(ProductStandardCost),'c','EN-US') as Product_Costs, 
Format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit, 
sum(OrderQuantity) as Quantity_Ordered, 
count(SalesOrderNumber) as Number_of_Orders, 
DimPC.ProductCategoryKey, 
Rank() over(order by sum(SalesAmount)) as Rank_Product  
from dbo.FactResellerSales as FRS
INNER JOIN dbo.DimProduct as DimP on FRS.ProductKey = DimP.ProductKey
INNER JOIN dbo.DimProductSubCategory as DimPSC on DimP.ProductSubcategoryKey = DimPSC.ProductSubcategoryKey
INNER JOIN dbo.DimProductCategory as DimPC on DimPSC.ProductCategoryKey = DimPC.ProductCategoryKey
group by DimPC.ProductCategoryKey;

-- 3. What are the sales, product costs, profit, number of orders & quantity ordered for both internet & reseller sales by product category and ranked by sales?
select format(sum(SalesAmount),'c','EN-US') as Sales,  
Format(sum(ProductStandardCost),'c','EN-US') as Product_Costs, 
Format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit, 
sum(OrderQuantity) as Quantity_Ordered, 
count(SalesOrderNumber) as Number_of_Orders, DimPC.ProductCategoryKey, 
Rank() over(order by sum(SalesAmount)) as Rank_Product  
from dbo.FactInternetSales as FIS
INNER JOIN dbo.DimProduct as DimP on FIS.ProductKey = DimP.ProductKey
INNER JOIN dbo.DimProductSubCategory as DimPSC on DimP.ProductSubcategoryKey = DimPSC.ProductSubcategoryKey
INNER JOIN dbo.DimProductCategory as DimPC on DimPSC.ProductCategoryKey = DimPC.ProductCategoryKey
group by DimPC.ProductCategoryKey

Union all

select format(sum(SalesAmount),'c','EN-US') as Sales,  
Format(sum(ProductStandardCost),'c','EN-US') as Product_Costs, 
Format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit, 
sum(OrderQuantity) as Quantity_Ordered, 
count(SalesOrderNumber) as Number_of_Orders, 
DimPC.ProductCategoryKey, 
Rank() over(order by sum(SalesAmount)) as Rank_Product  
from dbo.FactResellerSales as FRS
INNER JOIN dbo.DimProduct as DimP on FRS.ProductKey = DimP.ProductKey
INNER JOIN dbo.DimProductSubCategory as DimPSC on DimP.ProductSubcategoryKey = DimPSC.ProductSubcategoryKey
INNER JOIN dbo.DimProductCategory as DimPC on DimPSC.ProductCategoryKey = DimPC.ProductCategoryKey
group by DimPC.ProductCategoryKey;

-- 4. What are the sales, product costs, profit, number of orders & quantity ordered for product category Accessories broken-down by Product Hierarchy (Category, Subcategory, Model & Product) for both internet & reseller sales?
select format(sum(SalesAmount),'c','EN-US') as Sales, 
Format(sum(ProductStandardCost),'c','EN-US') as Product_Cost, 
Format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit, 
sum(OrderQuantity) as Quantity_Ordered, 
count(SalesOrderNumber) as Number_of_Orders, 
DimP.ProductSubcategoryKey, DimP.ModelName, DimP.ProductKey, DimPC.ProductCategoryKey 
from dbo.FactInternetSales as FIS
INNER JOIN dbo.DimProduct as DimP on FIS.ProductKey = DimP.ProductKey
INNER JOIN dbo.DimProductSubCategory as DimPSC on DimP.ProductSubcategoryKey = DimPSC.ProductSubcategoryKey
INNER JOIN dbo.DimProductCategory as DimPC on DimPSC.ProductCategoryKey = DimPC.ProductCategoryKey
group by DimPC.ProductCategoryKey, DimP.ProductSubcategoryKey, DimP.ModelName, DimP.ProductKey

Union all

select format(sum(SalesAmount),'c','EN-US') as Sales, 
Format(sum(ProductStandardCost),'c','EN-US') as Product_Cost, 
Format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit, 
sum(OrderQuantity) as Quantity_Ordered, 
count(SalesOrderNumber) as Number_of_Orders, 
DimP.ProductSubcategoryKey, DimP.ModelName, DimP.ProductKey, DimPC.ProductCategoryKey 
from dbo.FactResellerSales as FRS
INNER JOIN dbo.DimProduct as DimP on FRS.ProductKey = DimP.ProductKey
INNER JOIN dbo.DimProductSubCategory as DimPSC on DimP.ProductSubcategoryKey = DimPSC.ProductSubcategoryKey
INNER JOIN dbo.DimProductCategory as DimPC on DimPSC.ProductCategoryKey = DimPC.ProductCategoryKey
group by DimPC.ProductCategoryKey, DimP.ProductSubcategoryKey, DimP.ModelName, DimP.ProductKey;

-- 5.	What are the sales, product costs, profit, number of orders & quantity ordered for both internet & reseller sales by country and ranked by sales?
Select Format(sum(SalesAmount),'c','en-US') as TotalSales,
Format(sum(TotalProductCost),'c','en-US') as Totalcost, 
Format(sum(SalesAmount-TotalProductCost),'c','en-US') as Profit,
count(OrderQuantity) as OrderQuantity,
count(SalesOrderNumber) as Number_of_order,
DimPC.ProductCategoryKey,
DimST.SalesTerritoryCountry as Country,
RANK() OVER (order by sum(SalesAmount) DESC) as Rank_of_Product 
from dbo.DimProductCategory as DimPC
inner join dbo.DimProductSubcategory as DimPSC on DimPC.ProductCategoryKey= DimPSC.ProductCategoryKey
inner join dbo.DimProduct as DimP on DimPSC.ProductSubcategoryKey=DimP.ProductSubcategoryKey
inner join dbo.FactResellerSales as FRS on DimP.ProductKey=FRS.ProductKey
inner join dbo.DimReseller as DR on FRS.ResellerKey=DR.ResellerKey
inner join dbo.DimGeography as DimG on DR.GeographyKey=DimG.GeographyKey
inner join dbo.DimSalesTerritory as DimST on DimG.SalesTerritoryKey=DimST.SalesTerritoryKey
group by DimST.SalesTerritoryCountry,DimPC.ProductCategoryKey

union all

Select Format(sum(SalesAmount),'c','en-US') as TotalSales,
Format(sum(TotalProductCost),'c','en-US') as Totalcost, 
Format(sum(SalesAmount-TotalProductCost),'c','en-US') as Profit,
count(OrderQuantity) as OrderQuantity,
count(SalesOrderNumber) as Number_of_order,
DimPC.ProductCategoryKey,
DimST.SalesTerritoryCountry as Country,
RANK() OVER (order by sum(SalesAmount) DESC) as Rank_of_Product 
from dbo.DimProductCategory as DimPC
inner join dbo.DimProductSubcategory as DimPSC on DimPC.ProductCategoryKey= DimPSC.ProductCategoryKey
inner join dbo.DimProduct as DimP on DimPSC.ProductSubcategoryKey=DimP.ProductSubcategoryKey
inner join dbo.FactResellerSales as FRS on DimP.ProductKey=FRS.ProductKey
inner join dbo.DimReseller as DR on FRS.ResellerKey=DR.ResellerKey
inner join dbo.DimGeography as DimG on DR.GeographyKey=DimG.GeographyKey
inner join dbo.DimSalesTerritory as DimST on DimG.SalesTerritoryKey=DimST.SalesTerritoryKey
group by DimST.SalesTerritoryCountry,DimPC.ProductCategoryKey;

-- 6.	What are the sales, product costs, profit, number of orders & quantity ordered for France by city and ranked by sales for both internet & reseller sales?
Select Format(sum(SalesAmount),'c','en-US') as TotalSales,
Format(sum(TotalProductCost),'c','en-US') as Totalcost, 
Format(sum(SalesAmount-TotalProductCost),'c','en-US') as Profit,
count(OrderQuantity) as OrderQuantity,
count(SalesOrderNumber) as Number_of_order,
DimG.City as City,
RANK() OVER (order by sum(SalesAmount) DESC) as Rank_of_Product 
from dbo.DimProductCategory as DimPC
inner join dbo.DimProductSubcategory as DimPSC on DimPC.ProductCategoryKey=DimPSC.ProductCategoryKey
inner join dbo.DimProduct as DimP on DimPSC.ProductSubcategoryKey=DimP.ProductSubcategoryKey
inner join dbo.FactResellerSales as FRS on DimP.ProductKey=FRS.ProductKey
inner join dbo.DimReseller as DimR on FRS.ResellerKey=DimR.ResellerKey
inner join dbo.DimGeography as DimG on DimR.GeographyKey=DimG.GeographyKey
inner join dbo.DimSalesTerritory as DimST on DimG.SalesTerritoryKey=DimST.SalesTerritoryKey
where DimST.SalesTerritoryCountry='France' 
group by DimG.City

union all

Select Format(sum(SalesAmount),'c','en-US') as TotalSales, 
Format(sum(TotalProductCost),'c','en-US') as Totalcost, 
Format(sum(SalesAmount-TotalProductCost),'c','en-US') as Profit,
sum(OrderQuantity) as OrderQuantity,
count(SalesOrderNumber) as Number_of_order,
DimG.City as City,
RANK() OVER (order by sum(SalesAmount) DESC) as Rank_of_Product
from dbo.DimProductCategory as DimPC
inner join dbo.DimProductSubcategory as DimPSC on DimPC.ProductCategoryKey=DimPSC.ProductCategoryKey
inner join dbo.DimProduct as DimP on DimPSC.ProductSubcategoryKey=DimP.ProductSubcategoryKey
inner join dbo.FactInternetSales as FIS on DimP.ProductKey=FIS.ProductKey
inner join dbo.DimSalesTerritory as DimST on FIS.SalesTerritoryKey=DimST.SalesTerritoryKey
inner join dbo.DimGeography as DimG on DimST.SalesTerritoryKey=DimG.SalesTerritoryKey
where DimST.SalesTerritoryCountry='France' 
group by DimG.City;

-- 7. What are the top ten resellers by reseller hierarchy (business type, reseller name) ranked by sales?
select top(10) DimR.BusinessType as Business_Type, DimR.ResellerName as Reseller_name, RANK() OVER (order by sum(FIS.SalesAmount) DESC) as Rank_of_Product 
from dbo.DimReseller as DimR
inner join dbo.FactResellerSales as FRS on DimR.ResellerKey = FRS.ResellerKey
inner join dbo.FactInternetSales as FIS on FRS.ProductKey = FIS.ProductKey
group by DimR.BusinessType, DimR.ResellerName;

-- 8. What are the top ten (internet) customers ranked by sales?
select top(10) DimC.FirstName, DimC.MiddleName, DimC.LastName, Format(sum(FIS.SalesAmount),'c','EN-US') as SalesAmount, RANK() OVER (order by sum(FIS.SalesAmount) DESC) as Ranked_by_Sales 
from dbo.DimCustomer as DimC
inner join dbo.FactInternetSales as FIS on DimC.CustomerKey = FIS.CustomerKey
group by DimC.FirstName, DimC.MiddleName, DimC.LastName;

-- 9. What are the sales, product costs, profit, number of orders & quantity ordered by Customer Occupation?
select format(sum(SalesAmount),'c','EN-US') as Sales,
Format(sum(ProductStandardCost),'c','EN-US') as Product_Costs, 
Format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit, 
sum(OrderQuantity) as Quantity_Ordered, 
count(SalesOrderNumber) as Number_of_Orders, 
DimC.EnglishOccupation as Customer_Occupation,
Rank() over(order by sum(SalesAmount)) as Rank_Product  from dbo.FactInternetSales as FIS
inner join dbo.DimCustomer as DimC on FIS.CustomerKey = DimC.CustomerKey
group by DimC.EnglishOccupation;

-- 10. What are the ranked sales of the sales people (employees)?
select dbo.DimEmployee.FirstName, dbo.DimEmployee.LastName, 
format(sum(dbo.FactResellerSales.SalesAmount),'c','EN-US') as Total_Sales,
rank() over(order by sum(dbo.FactResellerSales.SalesAmount)desc) as Ranked_Sales from dbo.FactResellerSales
inner join dbo.DimEmployee on dbo.FactResellerSales.EmployeeKey=dbo.DimEmployee.EmployeeKey
group by dbo.DimEmployee.FirstName, dbo.DimEmployee.LastName;

-- 11.	What are the sales, discount amounts (promotion discounts), profit and promotion % of sales for Reseller Sales by Promotion Hierarchy (Category, Type & Name) – sorted descending by sales.?
select format(sum(SalesAmount),'c','EN-US') as Sales,
format(sum(DiscountAmount),'c','EN-US') as Discount_Amount,
format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit,
(sum((UnitPriceDiscountPct)*(OrderQuantity))/100) as PromotionPct_of_Sales,
DimP.EnglishPromotionType as Promotion_Type, DimP.EnglishPromotionName as Promotion_Name, DimP.EnglishPromotionCategory as Promotion_Category,
Rank() over(order by sum(SalesAmount) desc) as Rank_Product 
from dbo.FactResellerSales as FRS
inner join dbo.DimPromotion as DimP on FRS.PromotionKey = DimP.PromotionKey
group by DimP.EnglishPromotionType, DimP.EnglishPromotionName, DimP.EnglishPromotionCategory

-- 12.	What are the sales, product costs, profit, number of orders & quantity ordered by Sales Territory Hierarchy (Group, Country, region) and ranked by sales for both internet & reseller sales?
select format(sum(SalesAmount),'c','EN-US') as Sales,
format(sum(DiscountAmount),'c','EN-US') as Discount_Amount,
format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit,
sum(OrderQuantity) as Quantity_Ordered, 
count(SalesOrderNumber) as Number_of_Orders, 
DimST.SalesTerritoryGroup as Territory_Group, DimST.SalesTerritoryCountry as Teritory_Country, DimST.SalesTerritoryRegion as Territory_Region
from dbo.FactResellerSales as FRS
inner join dbo.DimSalesTerritory as DimST on FRS.SalesTerritoryKey=DimST.SalesTerritoryKey
group by DimST.SalesTerritoryGroup, DimST.SalesTerritoryCountry, DimST.SalesTerritoryRegion

Union All

select format(sum(SalesAmount),'c','EN-US') as Sales,
format(sum(DiscountAmount),'c','EN-US') as Discount_Amount,
format(sum(SalesAmount - ProductStandardCost),'c','EN-US') as Profit,
sum(OrderQuantity) as Quantity_Ordered, 
count(SalesOrderNumber) as Number_of_Orders, 
DimST.SalesTerritoryGroup as Territory_Group, DimST.SalesTerritoryCountry as Teritory_Country, DimST.SalesTerritoryRegion as Territory_Region
from dbo.FactInternetSales as FIS
inner join dbo.DimSalesTerritory as DimST on FIS.SalesTerritoryKey=DimST.SalesTerritoryKey
group by DimST.SalesTerritoryGroup, DimST.SalesTerritoryCountry, DimST.SalesTerritoryRegion;

-- 13.	What are the sales by year by sales channels (internet, reseller & total)?
select YEAR(dbo.FactInternetSales.ShipDate) as years_internet, Format(sum(dbo.FactInternetSales.SalesAmount),'c','en-US') as totalsales_internet,
YEAR(dbo.FactResellerSales.ShipDate) as years_reseller, Format(sum(dbo.FactResellerSales.SalesAmount),'c','en-US') as totalsales_reseller, Format((dbo.FactInternetSales.SalesAmount+dbo.FactResellerSales.SalesAmount),'c','en-US') as total 
from dbo.FactInternetSales
inner join dbo.FactResellerSales on dbo.FactResellerSales.ProductKey=dbo.FactInternetSales.ProductKey
group by YEAR(dbo.FactInternetSales.ShipDate),YEAR(dbo.FactResellerSales.ShipDate), Format((dbo.FactInternetSales.SalesAmount+dbo.FactResellerSales.SalesAmount),'c','en-US');

-- 14. What are the total sales by month (& year)?
select 'Internet Sales' as type, 
format(sum(dbo.FactInternetSales.SalesAmount),'c','EN-US') as total_sales,
dbo.DimDate.CalendarYear as year, 
dbo.DimDate.EnglishMonthName as month
from dbo.FactInternetSales
inner join dbo.DimDate on dbo.FactInternetSales.OrderDateKey=dbo.DimDate.DateKey
group by dbo.DimDate.CalendarYear, dbo.DimDate.EnglishMonthName

union all

select 'Reseller Sales' as type, 
format(sum(dbo.FactResellerSales.SalesAmount),'c','EN-US') as total_sales,
dbo.DimDate.CalendarYear as year, 
dbo.DimDate.EnglishMonthName as month
from dbo.FactResellerSales
inner join dbo.DimDate on dbo.FactResellerSales.OrderDateKey=dbo.DimDate.DateKey
group by dbo.DimDate.CalendarYear, dbo.DimDate.EnglishMonthName
order by dbo.DimDate.CalendarYear, dbo.DimDate.EnglishMonthName;
