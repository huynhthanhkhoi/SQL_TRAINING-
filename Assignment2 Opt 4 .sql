USE AdventureWorks2008
GO

----------------------------------------- 1.	Exercise 1
-- Query 1 
SELECT ProductID,Name,Color,LIStPrice FROM Production.Product

/* 
-- Query 2 Continue to work with the previous query and exclude those rows that are 0 for 
-- the column LIStPrice. Your result set should look something like the following.
*/  
SELECT ProductID,Name,Color,LIStPrice FROM Production.Product WHERE LIStPrice >0

/* 
Query 3 Use the same query, but thIS time you just want to see the rows that are 
NULL for the Color column. Your result set should look something like the following.  
*/

SELECT ProductID,Name,Color,LIStPrice FROM Production.Product WHERE Color IS NULL

/* 
Query 4 Use the same query, but thIS time you just want to see the rows that are NOT 
NULL for the Color column. Your result set should look something like the following  
*/
SELECT ProductID,Name,Color,LIStPrice FROM Production.Product WHERE Color IS NOT NULL


-- Query 5 

select ProductID,Name,Color,LIStPrice FROM Production.Product WHERE Color IS NOT NULL and LIStPrice >0

-- Query 6

 SELECT Name + ' : ' + Color AS NameAndColor FROM Production.Product WHERE Color IS NOT NULL


 -- Query 7 

 SELECT 'Name: ' + Name + ' -- ' + 'COLOR: ' + Color AS NameAndColor FROM Production.Product WHERE Color IS NOT NULL

 -- QUERY 8 

 SELECT ProductID,Name FROM Production.Product WHERE ProductID BETWEEN 400 AND 500


 -- QUERY 9

 SELECT ProductID,Name,Color FROM Production.Product WHERE Color='Black' or Color='Blue'

 -- Query 10 

 SELECT Name,LIStPrice FROM Production.Product WHERE Name LIKE 'S%'

  -- Query 11 

 SELECT Name,LIStPrice FROM Production.Product WHERE Name LIKE 'S%' or Name LIKE 'A%'

  -- Query 12

SELECT Name,LIStPrice FROM Production.Product WHERE Name LIKE 'Spo%' and Name NOT LIKE 'Spok%'

-- Query 13 DISTINCT

SELECT dIStinct Color FROM Production.Product 

-- Query 14 DISTINCT

SELECT DISTINCT ProductSubcategoryID,Color FROM Production.Product WHERE ProductSubcategoryID IS NOT NULL and Color IS NOT NULL 

-- Query 15

SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, LIStPrice
FROM Production.Product
WHERE (Color IN ('Red','Black') 
      AND (LIStPrice BETWEEN 1000 AND 2000)) 
      OR ProductSubCategoryID = 1
ORDER BY ProductID


-- QUERY 16 

SELECT ISNULL(Color, 'Unknow') AS Color,Name, ListPrice FROM Production.Product

----------------------------------------- 1.	Exercise 2

-- QUERY 1 CÓ TẤT CẢ BAO NHIÊU SẢN PHẨM

SELECT COUNT(ProductID) AS TotalRow FROM Production.Product

-- QUERY 2 CÓ BAO NHIÊU SẢN PHẨM CÓ DANH MỤC CON
SELECT COUNT(ProductID) AS HasSubCategoryID FROM Production.Product WHERE ProductSubcategoryID IS NOT NULL

-- QUERY 3 CÓ BAO NHIÊU SẢN PHẨN NẰM TRONG MỖI DANH MỤC CON

SELECT ProductSubcategoryID, COUNT(ProductID) AS CountedProducts FROM Production.Product 
GROUP BY ProductSubcategoryID

-- QUERY 4 VIẾT 2 CÂU QUERY LẤY RA TỔNG SỐ SẢN PHẨM KO CÓ SUBCATEGORY 
-- 1 CÂU CÓ WHERE 1 CÂU KHÔNG SỬ DỤNG WHERE

SELECT COUNT(ProductID) AS NoSubCat FROM Production.Product WHERE ProductSubcategoryID IS NULL
-------------
SELECT COUNT(ProductID) AS NoSubCat 
FROM Production.Product GROUP BY ProductSubcategoryID
HAVING ProductSubcategoryID IS NULL

-- QUERY 5

SELECT ProductID, SUM(Quantity) AS TheSum FROM Production.ProductInventory
GROUP BY ProductID

-- QUERY 6

SELECT ProductID, SUM(Quantity) AS TheSum FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP BY ProductID
HAVING SUM(Quantity)<100 

-- QUERY 7 
SELECT Shelf,ProductID, SUM(Quantity) AS TheSum FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP BY ProductID,Shelf
HAVING SUM(Quantity)<100

-- QUERY 8
SELECT AVG(Quantity) AS TheAvg FROM Production.ProductInventory
WHERE LocationID = 10


-- QUERY 9

SELECT ProductID,Shelf, AVG(Quantity) AS TheAvg FROM Production.ProductInventory
WHERE LocationID = 10 AND Shelf !='N/A'
GROUP BY ProductID, Shelf


-- QUERY 10  

SELECT Class, Color, COUNT(Class) AS TheCount ,AVG(LIStPrice) AS AvgPrice 
FROM Production.Product 
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY GROUPING SETS(Class, Color) 


-- QUERY 11

SELECT ProductSubcategoryID
      , COUNT(Name) as Counted
FROM Production.Product
GROUP BY ROLLUP (ProductSubcategoryID)
 


