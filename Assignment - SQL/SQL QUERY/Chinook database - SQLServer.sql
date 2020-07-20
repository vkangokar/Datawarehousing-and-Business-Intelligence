use Chinook;

select * from invoiceline;

-- a.	Total sales 
select sum(quantity*unitprice) as total_sales from invoiceline;

-- b.	Total sales by country – ranked
select sum(quantity*unitprice) as total_sales, inv.billingcountry from invoiceline invl
INNER JOIN invoice inv on invl.invoiceid = inv.invoiceid
group by inv.billingcountry 
order by total_sales desc;

-- c.	Total sales by country, state & city
select sum(Total) as "Total_Sales" ,i.BillingCountry, i.BillingState, i.BillingCity from invoice i
inner join customer c on i.CustomerId = c.CustomerId
group by i.BillingCountry,i.BillingState,i.BillingCity
order by Total_sales desc;

-- d.	Total sales by customer – ranked
select * from Customer;
select concat(cus.FirstName,cus.LastName) as Customer_name, sum(quantity*unitprice) as Total_sales from invoiceline invl
INNER JOIN invoice inv on invl.invoiceid = inv.invoiceid
INNER JOIN Customer cus on inv.customerid = cus.customerid
group by cus.FirstName,cus.LastName
order by Total_sales desc;

-- e.	Total sales by artist – ranked
select ar.name as Artist, sum(invl.quantity*invl.unitprice) as Total_sales from invoiceline invl
INNER JOIN track t on invl.trackid = t.trackid
INNER JOIN album a on t.albumid = a.albumid
INNER JOIN artist ar on a.artistid = ar.artistid
group by ar.Name
order by Total_sales desc;

-- f.	Total sales by artist & their albums
select ar.name as Artist, a.title as Album, sum(invl.quantity*invl.unitprice) as Total_sales from invoiceline invl
INNER JOIN track t on invl.trackid = t.trackid
INNER JOIN album a on t.albumid = a.albumid
INNER JOIN artist ar on a.artistid = ar.artistid
group by ar.Name, a.Title
order by Total_sales desc;

-- g.	Total sales by sales person (employee)
select month(BirthDate), YEAR(BirthDate) from Employee;
select DATEDIFF(YY,e.BirthDate,GETDATE()) as Age , concat(e.firstname,e.lastname) as Sales_Person, sum(quantity*unitprice) as Total_sales , count(Quantity) as Quantity from employee e
INNER JOIN customer c on e.employeeid = c.supportrepid
INNER JOIN invoice i on i.customerid = c.customerid
INNER JOIN invoiceline on i.invoiceid = invoiceline.invoiceid
group by e.employeeid;

-- h. Total tracks bought and total cost by media type
select mt.name as MediaType, sum(invl.quantity) as Quantity, sum(invl.quantity*invl.unitprice) as "Total_cost_by_media_type" from invoiceline invl
INNER JOIN track t on invl.trackid = t.trackid
INNER JOIN mediatype mt on t.mediatypeid = mt.mediatypeid
group by MediaType
order by Total_cost_by_media_type, quantity desc; 