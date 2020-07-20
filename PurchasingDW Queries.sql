use AdventureWorks2017;

-- Ranked order of Vendors by purchase amount $

select Vendor.BusinessEntityID, sum(PurchaseOrderHeader.TotalDue) as amount , rank() over (order by sum(PurchaseOrderHeader.TotalDue) desc) as rank
from Purchasing.Vendor 
join Purchasing.PurchaseOrderHeader ON Vendor.BusinessEntityID=PurchaseOrderHeader.VendorID
group by Vendor.BusinessEntityID
order by rank

select Vendor.BusinessEntityID, sum(PurchaseOrderHeader.SubTotal) as amount , rank() over (order by sum(PurchaseOrderHeader.SubTotal) desc) as rank
from Purchasing.Vendor 
join Purchasing.PurchaseOrderHeader ON Vendor.BusinessEntityID=PurchaseOrderHeader.VendorID
group by Vendor.BusinessEntityID
order by rank

select Vendor.BusinessEntityID, sum(PurchaseOrderDetail.LineTotal*PurchaseOrderDetail.UnitPrice) as amount , rank() over (order by sum(PurchaseOrderHeader.TotalDue) desc) as rank
from Purchasing.Vendor 
join Purchasing.PurchaseOrderHeader ON Vendor.BusinessEntityID=PurchaseOrderHeader.VendorID
join Purchasing.PurchaseOrderDetail on PurchaseOrderHeader.PurchaseOrderID=PurchaseOrderDetail.PurchaseOrderID
group by Vendor.BusinessEntityID
order by rank

--Ranked order of products purchased by amount $
--By category
select p.Name,sum(po.TotalDue) as 'Amount', rank() over (order by sum(po.TotalDue)) Rank
from Production.ProductCategory pc 
join Production.ProductSubcategory ps on ps.ProductCategoryID=pc.ProductCategoryID
join Production.Product p on p.ProductSubcategoryID=ps.ProductSubcategoryID
join Purchasing.PurchaseOrderDetail pd on pd.ProductID=p.ProductID
join Purchasing.PurchaseOrderHeader po on po.PurchaseOrderID=pd.PurchaseOrderID
group by p.Name
order by rank

select p.Name,sum(po.SubTotal) as 'Amount', rank() over (order by sum(po.SubTotal)) Rank
from Production.ProductCategory pc 
join Production.ProductSubcategory ps on ps.ProductCategoryID=pc.ProductCategoryID
join Production.Product p on p.ProductSubcategoryID=ps.ProductSubcategoryID
join Purchasing.PurchaseOrderDetail pd on pd.ProductID=p.ProductID
join Purchasing.PurchaseOrderHeader po on po.PurchaseOrderID=pd.PurchaseOrderID
group by p.Name
order by rank

-- By subcategory
select ps.Name,sum(po.TotalDue) as 'Amount', rank() over (order by sum(po.TotalDue)) Rank
from Production.ProductSubcategory ps
join Production.Product p on p.ProductSubcategoryID=ps.ProductSubcategoryID
join Purchasing.PurchaseOrderDetail pd on pd.ProductID=p.ProductID
join Purchasing.PurchaseOrderHeader po on po.PurchaseOrderID=pd.PurchaseOrderID
group by ps.Name
order by rank

select ps.Name,sum(po.SubTotal) as 'Amount', rank() over (order by sum(po.SubTotal)) Rank
from Production.ProductSubcategory ps
join Production.Product p on p.ProductSubcategoryID=ps.ProductSubcategoryID
join Purchasing.PurchaseOrderDetail pd on pd.ProductID=p.ProductID
join Purchasing.PurchaseOrderHeader po on po.PurchaseOrderID=pd.PurchaseOrderID
group by ps.Name
order by rank

-- By product model (top 20)
select TOP 20 pm.Name,sum(po.TotalDue) as 'Amount', rank() over (order by sum(po.TotalDue)) Rank
from Production.ProductModel pm
join Production.Product p on p.ProductModelID=pm.ProductModelID
join Purchasing.PurchaseOrderDetail pd on pd.ProductID=p.ProductID
join Purchasing.PurchaseOrderHeader po on po.PurchaseOrderID=pd.PurchaseOrderID
group by pm.Name
order by rank

select TOP 20 pm.Name,sum(po.SubTotal) as 'Amount', rank() over (order by sum(po.SubTotal)) Rank
from Production.ProductModel pm
join Production.Product p on p.ProductModelID=pm.ProductModelID
join Purchasing.PurchaseOrderDetail pd on pd.ProductID=p.ProductID
join Purchasing.PurchaseOrderHeader po on po.PurchaseOrderID=pd.PurchaseOrderID
group by pm.Name
order by rank

-- By product (top 20)
select top 20 p.Name,sum(po.TotalDue) as 'Amount', rank() over (order by sum(po.TotalDue)) Rank
from Production.Product p
join Purchasing.PurchaseOrderDetail pd on pd.ProductID=p.ProductID
join Purchasing.PurchaseOrderHeader po on po.PurchaseOrderID=pd.PurchaseOrderID
group by p.Name
order by rank

select top 20 p.Name,sum(po.SubTotal) as 'Amount', rank() over (order by sum(po.SubTotal)) Rank
from Production.Product p
join Purchasing.PurchaseOrderDetail pd on pd.ProductID=p.ProductID
join Purchasing.PurchaseOrderHeader po on po.PurchaseOrderID=pd.PurchaseOrderID
group by p.Name
order by rank

-- List of employees who purchased products with phone, email & address
Select p.firstname,p.LastName,ph.PhoneNumber,em.EmailAddress, concat(ad.AddressLine1,ad.AddressLine2,ad.City,ad.PostalCode) as Address, rank() over (order by p.firstname) Rank
from Person.person p
join HumanResources.Employee e on e.BusinessEntityID=p.BusinessEntityID
join Person.PersonPhone ph on ph.BusinessEntityID=p.BusinessEntityID
join Person.EmailAddress em on em.BusinessEntityID=p.BusinessEntityID
join Person.BusinessEntityAddress bd on bd.BusinessEntityID=p.BusinessEntityID
join person.Address ad on ad.AddressID=bd.AddressID
order by Rank

-- List of employees who purchased products with pay rate & raises (SCD)
select purchasing.PurchaseOrderHeader.EmployeeID,Person.Person.FirstName, person.person.LastName  ,HumanResources.EmployeePayHistory.Rate , sum(HumanResources.EmployeePayHistory.PayFrequency*HumanResources.EmployeePayHistory.Rate) AS Raises
from HumanResources.Employee
inner join person.Person on Person.person.BusinessEntityID=HumanResources.Employee.BusinessEntityID
inner join HumanResources.EmployeePayHistory on  HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.Employee.BusinessEntityID
inner join Purchasing.PurchaseOrderHeader on Purchasing.PurchaseOrderHeader.EmployeeID= HumanResources.Employee.BusinessEntityID
inner join Purchasing.PurchaseOrderDetail on purchasing.PurchaseOrderDetail.PurchaseOrderID=Purchasing.PurchaseOrderHeader.PurchaseOrderID
inner join Production.Product on Production.Product.ProductID=PurchaseOrderDetail.ProductID
where Production.Product.MakeFlag=0
group by  Person.person.FirstName, person.person.LastName,HumanResources.EmployeePayHistory.Rate,HumanResources.EmployeePayHistory.RateChangeDate,purchasing.PurchaseOrderHeader.EmployeeID
order by purchasing.PurchaseOrderHeader.EmployeeID;

-- List of purchasing vendor contacts with vendor name, phone, email & address

SELECT	distinct v.Name as 'Vendor Name',ad.AddressLine1 as Address,ad.City,ad.PostalCode,sp.Name as State,em.EmailAddress,ph.PhoneNumber
FROM	Purchasing.Vendor v,Person.Address ad,Person.BusinessEntity BE,Person.BusinessEntityContact Bec,Person.BusinessEntityAddress Ba, Person.EmailAddress em,Person.StateProvince sp, Person.PersonPhone ph,Person.Person p
Where v.BusinessEntityID=be.BusinessEntityID
AND	be.BusinessEntityID=ba.BusinessEntityID
AND	ba.AddressID=ad.AddressID
AND	ad.StateProvinceID=sp.StateProvinceID
AND	BE.BusinessEntityID=BEC.BusinessEntityID
AND	BEC.PersonID = p.BusinessEntityID
AND	p.BusinessEntityID=em.BusinessEntityID
AND	p.BusinessEntityID=ph.BusinessEntityID
And	p.PersonType='VC'
Order By 'Vendor Name'


--List of standard costs by product order by product and SCD effective ascending

select Production.Product.ProductID, Production.ProductCostHistory.StandardCost as StandardCost,Production.ProductCostHistory.StartDate, Production.ProductCostHistory.EndDate,Production.Product.Name from Production.Product
inner join Production.ProductCostHistory on Production.ProductCostHistory.ProductID=Production.Product.ProductID
where Production.Product.MakeFlag=0
group by Production.Product.ProductID, Production.ProductCostHistory.StandardCost,Production.ProductCostHistory.StartDate, Production.ProductCostHistory.EndDate,Production.Product.Name
order by Production.ProductCostHistory.StartDate,Production.ProductCostHistory.EndDate asc;

-- List of product prices by product order by product and SCD effective ascending

select Production.Product.ProductID, Production.ProductListPriceHistory.ListPrice as ListPrice,Production.ProductListPriceHistory.StartDate,Production.ProductListPriceHistory.EndDate,Production.Product.Name from Production.Product
inner join Production.ProductListPriceHistory on Production.ProductListPriceHistory.ProductID=Production.Product.ProductID
where Production.Product.MakeFlag=0
group by Production.Product.ProductID, Production.ProductListPriceHistory.ListPrice,Production.ProductListPriceHistory.StartDate,Production.ProductListPriceHistory.EndDate,Production.Product.Name
order by Production.ProductListPriceHistory.StartDate,Production.ProductListPriceHistory.EndDate asc;


