--SELECT * FROM Categories

--SELECT TOP 5 c.CategoryName,c.Description  FROM Categories c 

--SELECT * FROM Customers WHERE City NOT LIKE '%A%'

-- IS NULL / IS NOT NULL
--SELECT * FROM Customers WHERE PostalCode IS NULL AND Region IS NOT NULL

--SELECT * FROM Customers WHERE City IN ('Berlin','London')
--SELECT * FROM Customers WHERE City NOT IN ('Berlin','London') 

--SELECT 
--EmployeeID PersonelId, 
--FirstName PersonelAdi, 
--LastName PersonelSoyadi  
--FROM Employees 
--WHERE City = 'London' OR City='Tacoma'   

--SELECT * FROM Orders LEFT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID 

--SELECT Orders.OrderID, Orders.ShipCity, Employees.EmployeeID, Employees.City FROM Orders LEFT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID  

-- Subqueries Examples

--SELECT * FROM
--(SELECT P.ProductName,C.CategoryName FROM 
--Products P LEFT JOIN Categories C 
--ON P.CategoryID = C.CategoryID) A 
--WHERE A.CategoryName LIKE 'B%'

/*
SELECT J.Şirket_Adi, COUNT(J.Şirket_Adi) ADET FROM
(SELECT P.ProductName,S.CompanyName Şirket_Adi FROM Products P LEFT JOIN Suppliers S ON P.SupplierID = S.SupplierID) J
GROUP BY Şirket_Adi 
*/

--HAVING

/* SELECT CategoryID , SUM(UnitPrice) TOPLAM
FROM Products
GROUP BY CategoryID
WHERE SUM(UnitPrice)<200 HATALI KOD WHERE FROMDAN SONRA GELMELİ*/

/*
SELECT * FROM
(SELECT CategoryID , SUM(UnitPrice) TOPLAM
FROM Products
GROUP BY CategoryID) T1
WHERE T1.TOPLAM<200

-- VEYA

SELECT CategoryID , SUM(UnitPrice) TOPLAM
FROM Products
GROUP BY CategoryID
HAVING SUM(UnitPrice) < 200 
*/

/* SELECT AVG(T1.UnitPrice) ORTALAMA FROM
(SELECT TOP 5 ProductName,UnitPrice
FROM Products
ORDER BY UnitPrice ASC) T1 */ 


/*
SELECT TOP 1 ProductName,UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--VEYA

SELECT ProductName,UnitPrice FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products)

-- Bir sorgunun çıktısı başka sorguda parametre olarak kullanıldı.
*/ 

--UNION 

/* SELECT * FROM
(SELECT TOP 1 * FROM Products ORDER BY UnitPrice DESC) T1

UNION

SELECT * FROM
(SELECT TOP 1 * FROM Products ORDER BY UnitPrice ASC) T2 */

--DATEDIFF FUNCTION

/* SELECT OrderID, RequiredDate, ShippedDate, DATEDIFF(day,RequiredDate,ShippedDate) Gecikme FROM Orders
WHERE DATEDIFF(day,RequiredDate,ShippedDate) > 0
ORDER BY Gecikme DESC */



/*SELECT * FROM
(SELECT OrderID, RequiredDate, ShippedDate, DATEDIFF(day,RequiredDate,ShippedDate) Gecikme FROM Orders
WHERE DATEDIFF(day,RequiredDate,ShippedDate) > 0
) T1
ORDER BY T1.Gecikme DESC */


--ÖDEV-1
SELECT AVG(T1.Gecikme_Süresi) Gecikme FROM
(SELECT OrderID, RequiredDate, ShippedDate, DATEDIFF(day,RequiredDate,ShippedDate) Gecikme_Süresi FROM Orders
WHERE DATEDIFF(day,RequiredDate,ShippedDate) > 0
) T1

--ÖDEV-2
SELECT AVG(T1.Erken_Gelme_Süresi) Erken_Gelme FROM
(SELECT OrderID, RequiredDate, ShippedDate, DATEDIFF(day,ShippedDate,RequiredDate) Erken_Gelme_Süresi FROM Orders
WHERE DATEDIFF(day,ShippedDate,RequiredDate) > 0 
) T1

--ÖDEV-3
SELECT Customer_ID , SUM(T1.Monetary) FROM
(SELECT * , (Quantity*Price) AS Monetary FROM dbo.retail_2010_2011) T1
GROUP BY Customer_ID
ORDER BY Customer_ID

--ÖDEV-4
SELECT *, DATEDIFF(DAY,Last_Shopping_Date,'2011-12-30 00:00:00.000') Recency FROM
(SELECT Customer_ID,MAX(InvoiceDate) AS Last_Shopping_Date FROM dbo.retail_2010_2011
GROUP BY Customer_ID) T1
ORDER BY T1.Last_Shopping_Date DESC 

--ÖDEV-5
SELECT T1.Country,MAX(T1.Quantity) ADET ,Price  FROM  
(SELECT Country,[Description],Quantity,Price,(Quantity * Price) Monetary FROM dbo.retail_2010_2011) T1
GROUP BY Country 
HAVING Price = (SELECT Country,[Description],Quantity,Price,(Quantity * Price) Monetary FROM dbo.retail_2010_2011 GROUP BY Country HAVING Quantity = MAX(T1.Quantity))







--ORDER BY Country ASC , Miktar DESC 


