-- case studi

/*create database EsameSql;
use EsameSql;

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

-- 2. Tabella Prodotti (legata a Category)
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- 3. Tabella Regioni
CREATE TABLE Region (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(50) NOT NULL
);

-- 4. Tabella Stati (legata a Region)
CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50) NOT NULL,
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- 5. Tabella Vendite (il cuore del sistema)
CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    ProductID INT,
    CountryID INT,
    SaleDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

-- Inseriamo le Categorie (Gerarchia Prodotto)
INSERT INTO Category (CategoryID, CategoryName) VALUES (1, 'Bikes'), (2, 'Clothing');

-- Inseriamo i Prodotti collegandoli alle Categorie
INSERT INTO Product (ProductID, ProductName, CategoryID) VALUES 
(101, 'Bikes-100', 1), 
(102, 'Bikes-200', 1),
(103, 'Bike Glove M', 2);

-- Inseriamo le Regioni (Gerarchia Geografia)
INSERT INTO Region (RegionID, RegionName) VALUES (1, 'WestEurope'), (2, 'SouthEurope');

-- Inseriamo gli Stati collegandoli alle Regioni
INSERT INTO Country (CountryID, CountryName, RegionID) VALUES 
(1, 'France', 1), 
(2, 'Germany', 1),
(3, 'Italy', 2),
(4, 'Greece', 2);

-- Registriamo alcune Vendite (Sales)
INSERT INTO Sales (SalesID, ProductID, CountryID, SaleDate, Amount) VALUES 
(1, 101, 1, '2024-01-15', 500.00), -- Vendita di Bikes-100 in Francia
(2, 103, 3, '2024-01-16', 25.00);   -- Vendita di Guanti in Italia

-- verifica integrità
SELECT p.ProductName, c.CategoryName
FROM Product p
JOIN Category c ON p.CategoryID = c.CategoryID;

SELECT r.RegionName, SUM(s.Amount) AS TotaleVenduto
FROM Sales s
JOIN Country co ON s.CountryID = co.CountryID
JOIN Region r ON co.RegionID = r.RegionID
GROUP BY r.RegionName;

-- vendita totale stati per regione 
SELECT 
    R.RegionName AS Regione, 
    Co.CountryName AS Stato, 
    SUM(S.Amount) AS Totale_Vendite
FROM Sales S
JOIN Country Co ON S.CountryID = Co.CountryID
JOIN Region R ON Co.RegionID = R.RegionID
GROUP BY R.RegionName, Co.CountryName;

-- Qual è la categoria che incassa di più in assoluto?
SELECT 
    C.CategoryName, 
    SUM(S.Amount) AS Incasso_Totale
FROM Sales S
JOIN Product P ON S.ProductID = P.ProductID
JOIN Category C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName
ORDER BY Incasso_Totale DESC;

SELECT COUNT(SalesID) AS Tot, COUNT(DISTINCT SalesID) AS Unici FROM Sales;


-- sopra la media dell'ultimo anno 
SELECT ProductID, SUM(Amount) as TotaleVenduto
FROM Sales
WHERE YEAR(SaleDate) = (SELECT MAX(YEAR(SaleDate)) FROM Sales)
GROUP BY ProductID
HAVING SUM(Amount) > (SELECT AVG(Amount) FROM Sales WHERE YEAR(SaleDate) = (SELECT MAX(YEAR(SaleDate)) FROM Sales));

-- fatturato totale per prodotto per anno
SELECT ProductID, YEAR(SaleDate) AS Anno, SUM(Amount) AS Fatturato
FROM Sales 

-- Fatturato per stato per anno
SELECT Co.CountryName, YEAR(S.SaleDate) AS Anno, SUM(S.Amount) AS Fatturato
FROM Sales S
JOIN Country Co ON S.CountryID = Co.CountryID
GROUP BY Co.CountryName, YEAR(S.SaleDate)
ORDER BY Anno, Fatturato DESC; */

-- Categoria maggiormente richiesta
SELECT TOP 1 C.CategoryName, COUNT(S.SalesID) AS NumeroVendite
FROM Sales S
JOIN Product P ON S.ProductID = P.ProductID
JOIN Category C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName
ORDER BY NumeroVendite DESC;
-- task7
SELECT ProductName FROM Product WHERE ProductID NOT IN (SELECT ProductID FROM Sales);
-- task 7b
SELECT P.ProductName FROM Product P
LEFT JOIN Sales S ON P.ProductID = S.ProductID
WHERE S.SalesID IS NULL;
-- task8
CREATE VIEW View_Product_Info AS
SELECT P.ProductCode, P.ProductName, C.CategoryName
FROM Product P
JOIN Category C ON P.CategoryID = C.CategoryID;

CREATE VIEW View_Geo_Info AS
SELECT Co.CountryName, R.RegionName
FROM Country Co
JOIN Region R ON Co.RegionID = R.RegionID;



