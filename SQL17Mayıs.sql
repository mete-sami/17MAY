--1 Çalýþanýn Adý, Soyadý, Doðum Tarihini istiyorum
select
p.FirstName,
p.LastName,
e.BirthDate
from Person.Person p
inner join HumanResources.Employee e
on p.BusinessEntityID = e.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID=p.BusinessEntityID where edh.EndDate is Null

--2 Çalýþanýn Adý, Soyadý, Telefon Numarasý, Telefon numarasýnýn tipi istiyorum
select
p.FirstName,
p.LastName,
ph.PhoneNumber,
ph.PhoneNumberTypeID
from Person.Person p
inner join Person.PersonPhone ph on p.BusinessEntityID=ph.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID=p.BusinessEntityID 

select * from Person.Person
select * from Person.PersonPhone
select * from HumanResources.EmployeeDepartmentHistory 


-- Çalýþanýn Adý, Soyadý Departmanýnýn Adý (son çalýþtýðý departman listelenecek)
select p.FirstName,p.LastName,hd.Name from Person.Person p
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID
inner join HumanResources.Department hd on hd.DepartmentID = edh.DepartmentID
where edh.EndDate is null


-- Finance departmanýnda kaç adet çalýþan var?
select Count(*) from Person.Person as p
inner join HumanResources.EmployeeDepartmentHistory as h on h.BusinessEntityID=p.BusinessEntityID
inner join HumanResources.Department as d on d.DepartmentID=h.DepartmentID
where Lower(d.Name)= 'finance'and h.EndDate is null

-- Çalýþanýn adý soyadý ve EV TELEFONUNU ekrana yazdýr.
select p.FirstName,p.LastName, pp.PhoneNumber from Person.Person as p
inner join Person.PersonPhone as pp on pp.BusinessEntityID=p.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID where edh.EndDate is null and pp.PhoneNumberTypeID=2
select * from Person.PhoneNumberType
--Satýþ Sorularý
-- ADET BAZINDA en çok sipariþi veren müþterimin Id si,
select top 1 CustomerID,count(SalesOrderID) SiparisSayisi from Sales.SalesOrderHeader 
group by CustomerID order by SiparisSayisi  desc
-- Bugüne kadar verilmiþ en yüksek cirolu sipariþ
select Top(1)  SUM(OrderQty*(UnitPrice-(UnitPrice*UnitPriceDiscount)))hesapla,SalesOrderID from Sales.SalesOrderDetail group by SalesOrderID order by hesapla desc
select * from Sales.SalesOrderDetail
-- Sipariþ cirolarýmý TerriorityID ye göre grupla. 8, 564.000 
select soh.TerritoryID, SUM(soh.TotalDue) from Sales.SalesOrderHeader soh group by soh.TerritoryID order by soh.TerritoryID 
-- Kaç adet sipariþ gecikti?
select count(*) from Sales.SalesOrderHeader where ShipDate > DueDate
-- En çok sipariþim hangi bölgeye gecikti ve kaç adet?
select Top(1) COUNT(*) TerritoryID from Sales.SalesOrderHeader where ShipDate > DueDate  
select * from Sales.SalesOrderHeader
-- Vista kredi kartýyla kaç adet sipariþ verilmiþtir?
select Count(*) from Sales.CreditCard cc inner join Sales.SalesOrderHeader soh on cc.CreditCardID=soh.CreditCardID
select * from Sales.CreditCard
select * from Sales.SalesOrderHeader
-- Sipariþ hesaplamalaýrnda discount kolonu da kullanýlacak
select top 1 SUM(od.OrderQty * (od.UnitPrice*(1-od.UnitPriceDiscount))) SiparisTutari, od.SalesOrderID from 
Sales.SalesOrderDetail od 
group by od.SalesOrderID order by SiparisTutari desc
-- Taþýma Ücreti 50 den düþük sipariþlerimi yazdýr
Select * from Sales.SalesOrderHeader where Freight < 50