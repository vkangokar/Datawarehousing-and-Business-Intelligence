-- 1. What are the sales, product costs, profit, number of orders & quantity ordered for internet sales by product category and ranked by sales?

select format(sum(Production.Product.StandardCost),'c','en-US') as Totalcost,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
 sum(Sales.SalesOrderDetail.OrderQty) as Order_Quantity, 
 Count(Sales.SalesOrderHeader.SalesOrderID) as Number_of_Order,
 format(sum(Sales.SalesOrderHeader.SubTotal-Production.Product.StandardCost),'c','en-US') as Profit,
 Production.ProductCategory.Name,
 Rank() over (order by sum(Sales.SalesOrderHeader.SubTotal) desc) as Rank_by_Sales
 from Sales.SalesOrderDetail
 inner join Sales.SalesOrderHeader on Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
 inner join Production.Product on Sales.SalesOrderDetail.ProductID= Production.Product.ProductID
 inner join Production.ProductSubcategory on Production.Product.ProductSubcategoryID= Production.ProductSubcategory.ProductSubcategoryID
 inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID=Production.ProductSubcategory.ProductCategoryID
 Where Sales.SalesOrderHeader.OnlineOrderFlag=1
 group by Production.ProductCategory.Name;

 -- 2.	What are the sales, product costs, profit, number of orders & quantity ordered for reseller sales by product category and ranked by sales?
 select format(sum(Production.Product.StandardCost),'c','en-US') as Totalcost,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
 sum(Sales.SalesOrderDetail.OrderQty) as Order_Quantity, 
 Count(Sales.SalesOrderHeader.SalesOrderID) as Number_of_Order,
 format(sum(Sales.SalesOrderHeader.SubTotal-Production.Product.StandardCost),'c','en-US') as Profit,
 Production.ProductCategory.Name,
 Rank() over (order by sum(Sales.SalesOrderHeader.SubTotal) desc) as Rank_by_Sales
 from Sales.SalesOrderDetail
 inner join Sales.SalesOrderHeader on Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
 inner join Production.Product on Sales.SalesOrderDetail.ProductID= Production.Product.ProductID
 inner join Production.ProductSubcategory on Production.Product.ProductSubcategoryID= Production.ProductSubcategory.ProductSubcategoryID
 inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID=Production.ProductSubcategory.ProductCategoryID
 Where Sales.SalesOrderHeader.OnlineOrderFlag=0
 group by Production.ProductCategory.Name;

 -- 3.	What are the sales, product costs, profit, number of orders & quantity ordered for both internet & reseller sales by product category and ranked by sales?
  select format(sum(Production.Product.StandardCost),'c','en-US') as Totalcost,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
 sum(Sales.SalesOrderDetail.OrderQty) as Order_Quantity, 
 Count(Sales.SalesOrderHeader.SalesOrderID) as Number_of_Order,
 format(sum(Sales.SalesOrderHeader.SubTotal-Production.Product.StandardCost),'c','en-US') as Profit,
 Production.ProductCategory.Name,
 Rank() over (order by sum(Sales.SalesOrderHeader.SubTotal) desc) as Rank_by_Sales
 from Sales.SalesOrderDetail
 inner join Sales.SalesOrderHeader on Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
 inner join Production.Product on Sales.SalesOrderDetail.ProductID= Production.Product.ProductID
 inner join Production.ProductSubcategory on Production.Product.ProductSubcategoryID= Production.ProductSubcategory.ProductSubcategoryID
 inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID=Production.ProductSubcategory.ProductCategoryID
 Where Sales.SalesOrderHeader.OnlineOrderFlag=0 or Sales.SalesOrderHeader.OnlineOrderFlag=1
 group by Production.ProductCategory.Name;

 -- 4.	What are the sales, product costs, profit, number of orders & quantity ordered for product category Accessories broken-down by Product Hierarchy (Category, Subcategory, Model & Product) for both internet & reseller sales?
 select format(sum(Production.Product.StandardCost),'c','en-US') as Totalcost,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
 sum(Sales.SalesOrderDetail.OrderQty) as OrderQty,
 count(Sales.SalesOrderHeader.SalesOrderID) as Number_of_Order,
 format(sum(Sales.SalesOrderHeader.SubTotal - Production.Product.StandardCost),'c','en-US') as Profit,
 Production.ProductCategory.Name as Product_Category_Name, Production.ProductSubcategory.Name as Product_Subcategory_Name,Production.ProductModel.Name as Product_ModelName, Production.Product.Name as Product_Name,
 Rank() over (order by sum(Sales.SalesOrderHeader.SubTotal) desc) as Rank_by_Sales
 from Sales.SalesOrderDetail
 inner join Sales.SalesOrderHeader on Sales.SalesOrderHeader.SalesOrderID=SalesOrderDetail.SalesOrderID
 inner join Production.Product on Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
 inner join Production.ProductSubcategory on Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
 inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID
 inner join Production.ProductModel on Production.Product.ProductModelID = Production.ProductModel.ProductModelID
 where Sales.SalesOrderHeader.OnlineOrderFlag=0 or Sales.SalesOrderHeader.OnlineOrderFlag=1
 group by Production.ProductCategory.Name, Production.ProductSubcategory.Name, Production.ProductModel.Name, Production.Product.Name;

-- 5. What are the sales, product costs, profit, number of orders & quantity ordered for both internet & reseller sales by country and ranked by sales? 
select format(sum(Production.Product.StandardCost),'c','en-US') as Totalcost,
format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
sum(Sales.SalesOrderDetail.OrderQty) as OrderQty,
count(Sales.SalesOrderHeader.SalesOrderID) as Number_of_Order,
format(sum(Sales.SalesOrderHeader.SubTotal - Production.Product.StandardCost),'c','en-US') as Profit,
dense_Rank() over (order by sum(Sales.SalesOrderHeader.SubTotal) desc) as Rank_by_Sales,
Sales.CountryRegionCurrency.CountryRegionCode as Country
from Sales.SalesOrderDetail 
inner join Production.Product on Production.Product.ProductID=Sales.SalesOrderDetail.ProductID 
inner join Sales.SalesOrderHeader on Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
inner join Sales.SalesTerritory on Sales.SalesTerritory.TerritoryID=Sales.SalesTerritory.TerritoryID
inner join Sales.CountryRegionCurrency on Sales.CountryRegionCurrency.CountryRegionCode=Sales.SalesTerritory.CountryRegionCode
where Sales.SalesOrderHeader.OnlineOrderFlag=0 or Sales.SalesOrderHeader.OnlineOrderFlag=1
group by Sales.CountryRegionCurrency.CountryRegionCode;

-- 6.	What are the sales, product costs, profit, number of orders & quantity ordered for France by city and ranked by sales for both internet & reseller sales?
 select format(sum(Production.Product.StandardCost),'c','en-US') as Totalcost,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
 SUM(Sales.SalesOrderDetail.OrderQty) as Order_Quantity, 
 Count(Sales.SalesOrderHeader.SalesOrderID) as Number_of_Order,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as Profit,
 person.Address.City as City,
 Dense_Rank() over (order by sum(Sales.SalesOrderHeader.SubTotal) desc) as Rank_by_Sales
 from Sales.SalesOrderHeader
 inner join Sales.SalesOrderDetail on Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
 inner join Production.Product on Sales.SalesOrderDetail.ProductID= Production.Product.ProductID
 inner join Production.ProductSubcategory on Production.Product.ProductSubcategoryID= Production.ProductSubcategory.ProductSubcategoryID
 inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID=Production.ProductSubcategory.ProductCategoryID
 inner join sales.SalesTerritory on sales.SalesTerritory.TerritoryID=sales.SalesOrderHeader.TerritoryID
 inner join sales.SalesTerritoryHistory on sales.SalesTerritoryHistory.TerritoryID=sales.SalesTerritory.TerritoryID
 inner join Person.StateProvince on Person.StateProvince.CountryRegionCode=sales.SalesTerritory.CountryRegionCode
inner join person.CountryRegion on Person.CountryRegion.CountryRegionCode=person.StateProvince.CountryRegionCode
inner join person.Address on person.Address.StateProvinceID=person.StateProvince.StateProvinceID
 Where  person.CountryRegion.Name='France'
 group by  person.Address.City;

 -- 7.	What are the top ten resellers by reseller hierarchy (business type, reseller name) ranked by sales?
 select top (10) sales.vStoreWithDemographics.BusinessType, Sales.vStoreWithDemographics.Name,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','EN-US') as Total_Sales
 from sales.SalesOrderHeader
 inner join Sales.Store on Sales.SalesOrderHeader.SalesPersonID=Sales.Store.SalesPersonID
 inner join Sales.vStoreWithDemographics on Sales.Store.BusinessEntityID = Sales.vStoreWithDemographics.BusinessEntityID
 group by Sales.vStoreWithDemographics.BusinessType, Sales.vStoreWithDemographics.Name;

 -- 8.	What are the top ten (internet) customers ranked by sales?
 select top(10) person.Person.FirstName as FirstName, person.Person.LastName as LastName,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
 Rank() over (order by sum(Sales.SalesOrderHeader.SubTotal) desc) as Rank_by_Sales
 from Sales.SalesOrderHeader
 inner join Sales.CreditCard on Sales.CreditCard.CreditCardID=sales.SalesOrderHeader.CreditCardID
inner join sales.PersonCreditCard on sales.PersonCreditCard.CreditCardID=sales.CreditCard.CreditCardID
inner join person.Person on person.Person.BusinessEntityID=sales.PersonCreditCard.BusinessEntityID
where sales.SalesOrderHeader.OnlineOrderFlag=1
group by  person.Person.FirstName,person.Person.LastName;

 -- 9.	What are the sales, product costs, profit, number of orders & quantity ordered by Customer Occupation?
select format(sum(Production.Product.StandardCost),'c','en-US') as Totalcost,
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
 sum(Sales.SalesOrderDetail.OrderQty) as Order_Quantity, 
 Count(Sales.SalesOrderHeader.SalesOrderID) as Number_of_Order,
 format(sum(Sales.SalesOrderHeader.SubTotal-Production.Product.StandardCost),'c','en-US') as Profit,
 Sales.vPersonDemographics.Occupation as Customer_Occupation
 from Sales.SalesOrderDetail
 inner join Production.Product on Production.Product.ProductID=Sales.SalesOrderDetail.ProductID
 inner join Sales.SalesOrderHeader on Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
 inner join Sales.PersonCreditCard on Sales.PersonCreditCard.CreditCardID=Sales.SalesOrderHeader.CreditCardID
 inner join Sales.vPersonDemographics on Sales.vpersonDemographics.BusinessEntityID=Sales.PersonCreditCard.BusinessEntityID
 group by Sales.vPersonDemographics.Occupation; 

 -- 10. What are the ranked sales of the sales people (employees)?
 select Person.Person.FirstName, Person.Person.LastName, 
 format(sum(Sales.SalesOrderHeader.SubTotal),'c','EN-US') as Total_Sales,
 dense_rank() over(order by sum(Sales.SalesOrderHeader.SubTotal)desc) as 'Ranked_Sales' 
 from Sales.SalesOrderHeader
 inner join Sales.SalesPerson on Sales.SalesOrderHeader.TerritoryID = Sales.SalesPerson.TerritoryID
 inner join HumanResources.Employee on Sales.SalesPerson.BusinessEntityID = HumanResources.Employee.BusinessEntityID
 inner join Person.Person on HumanResources.Employee.BusinessEntityID=Person.Person.BusinessEntityID
 group by Person.Person.FirstName, Person.Person.LastName;

 -- 11.	What are the sales, discount amounts (promotion discounts), profit and promotion % of sales for Reseller Sales by Promotion Hierarchy (Category, Type & Name) – sorted descending by sales.?
Select Production.ProductCategory.Name as "Catogry",
Production.ProductSubcategory.Name as "Type",
Production.Product.Name as "Name",
format(Sum(Sales.SalesOrderHeader.subtotal), 'c', 'EN-US') As "TotalSales",
(Sales.SalesOrderDetail.UnitPriceDiscount) As"Discount",
format(Sum(Sales.SalesOrderDetail.LineTotal-Production.Product.StandardCost*Sales.SalesOrderDetail.OrderQty),'c','EN-US')  "Profit" ,
(Sales.SpecialOffer.DiscountPct) as "Discount%" from Sales.SalesOrderDetail
Inner Join Sales.SalesOrderHeader on Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
Inner Join Production.Product  on Sales.SalesOrderDetail.ProductID = Production.Product .ProductID
Inner join Production.ProductCategory on Production.Product.ProductSubcategoryID = Production.ProductCategory.ProductCategoryID
Inner JOin Production.ProductSubcategory on Production.ProductSubcategory.ProductCategoryID =Production.ProductCategory.ProductCategoryID
Inner Join Sales.SpecialOfferProduct on Sales.SpecialOfferProduct.ProductID= Sales.SalesOrderDetail.ProductID
Inner join Sales.SpecialOffer on Sales.SpecialOffer.SpecialOfferID=Sales.SpecialOfferProduct.SpecialOfferID
where Sales.SalesOrderHeader.OnlineOrderFlag = 0
Group by Production.ProductCategory.Name,Production.ProductSubcategory.Name,Production.Product.Name,Sales.SalesOrderDetail.UnitPriceDiscount,Sales.SpecialOffer.DiscountPct



 -- 12.	What are the sales, product costs, profit, number of orders & quantity ordered by Sales Territory Hierarchy (Group, Country, region) and ranked by sales for both internet & reseller sales?
 select st.[Group], cr.Name Country, cr.CountryRegionCode,sod.LineTotal Sales, p.StandardCost ProductCost, 
sod.LineTotal - (p.StandardCost * sod.OrderQty) Profit, 
count(soh.SalesOrderID) NumberOfOrders, SUM(sod.OrderQty) QuantityOfProduct 
from Production.Product p
inner join Sales.SalesOrderDetail sod on p.ProductID = sod.ProductID
inner join Sales.SalesOrderHeader soh on sod.SalesOrderID = soh.SalesOrderID
inner join Sales.SalesTerritory st on soh.TerritoryID = st.TerritoryID
inner join Person.StateProvince sp on st.CountryRegionCode = sp.CountryRegionCode
inner join Person.CountryRegion cr on sp.CountryRegionCode = cr.CountryRegionCode
group by st.[Group], cr.Name, cr.CountryRegionCode,sod.LineTotal, p.StandardCost, 
sod.LineTotal - (p.StandardCost * sod.OrderQty)
order by Sales desc;

 -- 13.	What are the sales by year by sales channels (internet, reseller & total)?
 select format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as TotalSales,
 YEAR(sales.SalesOrderHeader.OrderDate) as year, sales.SalesOrderHeader.OnlineOrderFlag as Sales_Channel
 from sales.SalesOrderHeader 
 inner join Sales.SalesOrderDetail on Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
 inner join Production.Product on Sales.SalesOrderDetail.ProductID= Production.Product.ProductID
 inner join Production.ProductSubcategory on Production.Product.ProductSubcategoryID= Production.ProductSubcategory.ProductSubcategoryID
 inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID=Production.ProductSubcategory.ProductCategoryID
 group by YEAR(sales.SalesOrderHeader.OrderDate),sales.SalesOrderHeader.OnlineOrderFlag
 order by YEAR(sales.SalesOrderHeader.OrderDate),sales.SalesOrderHeader.OnlineOrderFlag;
 
 -- 14.	What are the total sales by month (& year)?
 select format(sum(Sales.SalesOrderHeader.SubTotal),'c','en-US') as Total_Sales,
 YEAR(sales.SalesOrderHeader.OrderDate) as Year,  MONTH(sales.SalesOrderHeader.OrderDate) as Months
 from sales.SalesOrderHeader 
 group by YEAR(sales.SalesOrderHeader.OrderDate),MONTH(sales.SalesOrderHeader.OrderDate)
 order by YEAR(sales.SalesOrderHeader.OrderDate),MONTH(sales.SalesOrderHeader.OrderDate);