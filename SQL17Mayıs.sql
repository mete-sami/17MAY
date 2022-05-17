--1 �al��an�n Ad�, Soyad�, Do�um Tarihini istiyorum
select
p.FirstName,
p.LastName,
e.BirthDate
from Person.Person p
inner join HumanResources.Employee e
on p.BusinessEntityID = e.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID=p.BusinessEntityID where edh.EndDate is Null

--2 �al��an�n Ad�, Soyad�, Telefon Numaras�, Telefon numaras�n�n tipi istiyorum
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


-- �al��an�n Ad�, Soyad� Departman�n�n Ad� (son �al��t��� departman listelenecek)
select p.FirstName,p.LastName,hd.Name from Person.Person p
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID
inner join HumanResources.Department hd on hd.DepartmentID = edh.DepartmentID
where edh.EndDate is null


-- Finance departman�nda ka� adet �al��an var?
select Count(*) from Person.Person as p
inner join HumanResources.EmployeeDepartmentHistory as h on h.BusinessEntityID=p.BusinessEntityID
inner join HumanResources.Department as d on d.DepartmentID=h.DepartmentID
where Lower(d.Name)= 'finance'and h.EndDate is null

-- �al��an�n ad� soyad� ve EV TELEFONUNU ekrana yazd�r.
select p.FirstName,p.LastName, pp.PhoneNumber from Person.Person as p
inner join Person.PersonPhone as pp on pp.BusinessEntityID=p.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID where edh.EndDate is null and pp.PhoneNumberTypeID=2
select * from Person.PhoneNumberType
--Sat�� Sorular�
-- ADET BAZINDA en �ok sipari�i veren m��terimin Id si,
select top 1 CustomerID,count(SalesOrderID) SiparisSayisi from Sales.SalesOrderHeader 
group by CustomerID order by SiparisSayisi  desc
-- Bug�ne kadar verilmi� en y�ksek cirolu sipari�
select Top(1)  SUM(OrderQty*(UnitPrice-(UnitPrice*UnitPriceDiscount)))hesapla,SalesOrderID from Sales.SalesOrderDetail group by SalesOrderID order by hesapla desc
select * from Sales.SalesOrderDetail
-- Sipari� cirolar�m� TerriorityID ye g�re grupla. 8, 564.000 
select soh.TerritoryID, SUM(soh.TotalDue) from Sales.SalesOrderHeader soh group by soh.TerritoryID order by soh.TerritoryID 
-- Ka� adet sipari� gecikti?
select count(*) from Sales.SalesOrderHeader where ShipDate > DueDate
-- En �ok sipari�im hangi b�lgeye gecikti ve ka� adet?
select Top(1) COUNT(*) TerritoryID from Sales.SalesOrderHeader where ShipDate > DueDate  
select * from Sales.SalesOrderHeader
-- Vista kredi kart�yla ka� adet sipari� verilmi�tir?
select Count(*) from Sales.CreditCard cc inner join Sales.SalesOrderHeader soh on cc.CreditCardID=soh.CreditCardID
select * from Sales.CreditCard
select * from Sales.SalesOrderHeader
-- Sipari� hesaplamala�rnda discount kolonu da kullan�lacak
select top 1 SUM(od.OrderQty * (od.UnitPrice*(1-od.UnitPriceDiscount))) SiparisTutari, od.SalesOrderID from 
Sales.SalesOrderDetail od 
group by od.SalesOrderID order by SiparisTutari desc
-- Ta��ma �creti 50 den d���k sipari�lerimi yazd�r
Select * from Sales.SalesOrderHeader where Freight < 50