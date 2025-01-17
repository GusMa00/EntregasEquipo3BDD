--Fragmenos alojados en la instancia 1:
--Creacion de Fragmento AsiaPacific
Use AsiaPacific
GO
create schema Sales
GO
select * into AsiaPacific.Sales.Customer from AdventureWorks2019.Sales.Customer where TerritoryID=9
select * into AsiaPacific.Sales.SalesOrderHeader from AdventureWorks2019.Sales.SalesOrderHeader where TerritoryID=9
select * into AsiaPacific.Sales.SalesPerson from AdventureWorks2019.Sales.SalesPerson where TerritoryID=9
--SalesOrderDetail
select sod.SalesOrderID,sod.SalesOrderDetailID,sod.CarrierTrackingNumber,sod.OrderQty,sod.ProductID,
sod.SpecialOfferID,sod.UnitPrice,sod.UnitPriceDiscount,sod.LineTotal,sod.rowguid,sod.ModifiedDate into AsiaPacific.Sales.SalesOrderDetail
from AdventureWorks2019.Sales.SalesOrderDetail as sod left join
(select * from AdventureWorks2019.Sales.SalesOrderHeader where TerritoryID=9) as oh on sod.SalesOrderID=oh.SalesOrderID
GO

--Consulta 2
--2. Listar datos del empleado que atendi� m�s ordenes por territorio.
select * from 
(select top 1 SalesPersonID IMV, count(SalesOrderID) TV from Sales.SalesOrderHeader where  TerritoryID=9 and SalesPersonID>1 group by SalesPersonID order by TV desc) mv
inner join 
(select * from Sales.SalesPerson) sp 
on mv.IMV=sp.BusinessEntityID 


--Consulta 6
--6. Listar los 3 productos menos solicitados en la regi�n �Pacific�
Select TOP 3 WITH TIES SalesOrderDetail.ProductID, SUM(SalesOrderDetail.OrderQty) as Ventas 
from AsiaPacific.Sales.SalesOrderDetail
Group by SalesOrderDetail.ProductID 
Order by Ventas asc

select * from sales.Customer