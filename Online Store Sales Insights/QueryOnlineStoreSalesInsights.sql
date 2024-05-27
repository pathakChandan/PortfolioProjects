



SELECT *
FROM OnlineStoreSalesInsights..OnlineStoreSales


-- Data Cleaning and Validation

-- 1. Securing required columns only , i.e. Payment_Method field is not needed

SELECT Transaction_ID, Date, Product_Category, Product_Name, Units_Sold, Unit_Price, Total_Revenue, Region
FROM OnlineStoreSalesInsights..OnlineStoreSales


-- 2. Rounding fields Unit_Price and Total_Revenue to 2 decimal places only

SELECT Transaction_ID, Date, Product_Category, Product_Name, Units_Sold, 
	CAST(Unit_Price AS DECIMAL(10,2)) AS Unit_Price, 
	CAST(Total_Revenue AS DECIMAL(10,2)) AS Total_Revenue,
	Region
FROM OnlineStoreSalesInsights..OnlineStoreSales


-- 3. Data type check

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
Where TABLE_NAME = 'ViewOnlineStoreSales'



-- CREATING VIEWS

CREATE VIEW ViewOnlineStoreSales AS  

SELECT Transaction_ID, 
	Date, 
	CAST(Product_Category AS varchar(100)) AS Product_Category, 
	CAST(Product_Name AS varchar(100))AS Product_Name, 
	Units_Sold, 
	CAST(Unit_Price AS DECIMAL(10,2)) AS Unit_Price, 
	CAST(Total_Revenue AS DECIMAL(10,2)) AS Total_Revenue,
	CAST(Region AS varchar(100)) AS Region
FROM OnlineStoreSalesInsights..OnlineStoreSales

-- 4. Check for duplicate entries

SELECT Transaction_ID, COUNT(Transaction_ID) as cnt 
FROM ViewOnlineStoreSales
GROUP BY Transaction_ID
HAVING COUNT(Transaction_ID) >1
-- No duplicates found



CREATE VIEW ViewOnlineStoreSalesAsia AS
SELECT *
From ViewOnlineStoreSales
WHERE Region = 'Asia'


CREATE VIEW ViewOnlineStoreSalesNorthAmerica AS
SELECT *
From ViewOnlineStoreSales
WHERE Region = 'North America'


CREATE VIEW ViewOnlineStoreSalesSouthAmerica AS
SELECT *
From ViewOnlineStoreSales
WHERE Region = 'South America'


CREATE VIEW ViewOnlineStoreSalesEurope AS
SELECT *
From ViewOnlineStoreSales
WHERE Region = 'Europe'


CREATE VIEW ViewOnlineStoreSalesAfrica AS
SELECT *
From ViewOnlineStoreSales
WHERE Region = 'Africa'

Select Distinct Region 
From ViewOnlineStoreSales


CREATE VIEW ViewOnlineStoreSalesAustralia AS
SELECT *
From ViewOnlineStoreSales
WHERE Region = 'Australia'








