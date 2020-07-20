use chinook;
select * from invoiceline;

-- a.	Total sales 
select sum(quantity*unitprice) as total_sales from invoiceline;

-- b.	Total sales by country – ranked
select sum(quantity*unitprice) as total_sales, inv.billingcountry from invoiceline invl
INNER JOIN invoice inv on invl.invoiceid = inv.invoiceid
group by inv.billingcountry 
order by total_sales desc;

-- c.	Total sales by country, state & city
select sum(Total) as "Total_Sales" ,Country,State,City from invoice i
inner join customer c on i.CustomerId = c.CustomerId
group by Country
order by Total_Sales desc;

-- d.	Total sales by customer – ranked
select concat(cus.firstname,"",cus.lastname) as Customer_name, sum(quantity*unitprice) as Total_sales from invoiceline invl
INNER JOIN invoice inv on invl.invoiceid = inv.invoiceid
INNER JOIN customer cus on inv.customerid = cus.customerid
group by Customer_name
order by Total_sales desc;

-- e.	Total sales by artist – ranked
select ar.name as Artist, sum(invl.quantity*invl.unitprice) as Total_sales from invoiceline invl
INNER JOIN track t on invl.trackid = t.trackid
INNER JOIN album a on t.albumid = a.albumid
INNER JOIN artist ar on a.artistid = ar.artistid
group by Artist
order by Total_sales desc;

-- f.	Total sales by artist & their albums
select ar.name as Artist, a.title as Album, sum(invl.quantity*invl.unitprice) as Total_sales from invoiceline invl
INNER JOIN track t on invl.trackid = t.trackid
INNER JOIN album a on t.albumid = a.albumid
INNER JOIN artist ar on a.artistid = ar.artistid
group by Artist, Album
order by Total_sales desc;

-- g.	Total sales by sales person (employee)
ALTER TABLE employee
ADD age INT ;
UPDATE employee SET age= YEAR(CURDATE()) - YEAR(birthdate);

ALTER TABLE employee
ADD age_group Varchar(10);

alter table employee
drop age_group; 

UPDATE employee SET age_group= '40-50' where age between 40 and 50;
UPDATE employee SET age_group= '50-60' where age between 50 and 60;
UPDATE employee SET age_group= '60-70' where age between 60 and 70;
UPDATE employee SET age_group= '70-80' where age between 70 and 80;
select concat(e.firstname," ",e.lastname) as Sales_Person, sum(quantity*unitprice) as Total_sales , count(Quantity) as Quantity, age_group from employee e
INNER JOIN customer c on e.employeeid = c.supportrepid
INNER JOIN invoice i on i.customerid = c.customerid
INNER JOIN invoiceline on i.invoiceid = invoiceline.invoiceid
group by e.employeeid, age_group;

-- h. Total tracks bought and total cost by media type
select mt.name as MediaType, sum(invl.quantity) as Quantity, sum(invl.quantity*invl.unitprice) as "Total_cost_by_media_type" from invoiceline invl
INNER JOIN track t on invl.trackid = t.trackid
INNER JOIN mediatype mt on t.mediatypeid = mt.mediatypeid
group by MediaType
order by Total_cost_by_media_type, quantity desc; 