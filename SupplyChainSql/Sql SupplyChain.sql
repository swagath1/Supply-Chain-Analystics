use Supply_Chain;

DROP TABLE SUPPLYCHAIN;

CREATE TABLE SupplyChain
(
    Type VARCHAR(30) NOT NULL,

    Days_For_Shipping_Real INT NOT NULL,
    Days_For_Shipment_Scheduled INT NOT NULL,

    Benefit_Per_Order DECIMAL(18,2) NOT NULL,
    Sales_Per_Customer DECIMAL(18,2) NOT NULL,

    Delivery_Status VARCHAR(30) NOT NULL,
    Late_Delivery_Risk BIT NOT NULL,

    Category_ID INT NOT NULL,
    Category_Name VARCHAR(50) NOT NULL,

    Customer_City NVARCHAR(100) NOT NULL,
    Customer_Country VARCHAR(100) NOT NULL,
    Customer_ID INT NOT NULL,
    Customer_FullName VARCHAR(100) NOT NULL,
    Customer_Segment VARCHAR(30) NOT NULL,
    Customer_State NVARCHAR(100) NOT NULL,
    Customer_Street VARCHAR(150) NOT NULL,
    Customer_Zipcode INT NULL,

    Department_ID INT NOT NULL,
    Department_Name VARCHAR(50) NOT NULL,

    Latitude FLOAT NOT NULL,
    Longitude FLOAT NOT NULL,

    Market VARCHAR(50) NOT NULL,

    Order_City NVARCHAR(100) NOT NULL,
    Order_Country NVARCHAR(100) NOT NULL,

    Order_Date DATE NOT NULL,

    Order_ID INT NOT NULL,

    Order_Item_Discount DECIMAL(18,2) NOT NULL,
    Order_Item_Discount_Rate DECIMAL(10,4) NOT NULL,
    Order_Item_ID INT NOT NULL,
    Order_Item_Product_Price DECIMAL(18,2) NOT NULL,
    Order_Item_Profit_Ratio DECIMAL(10,6) NOT NULL,
    Order_Item_Quantity INT NOT NULL,

    Sales DECIMAL(18,2) NOT NULL,
    Order_Item_Total DECIMAL(18,2) NOT NULL,
    Order_Profit_Per_Order DECIMAL(18,2) NOT NULL,

    Order_Region NVARCHAR(100) NOT NULL,
    Order_State NVARCHAR(100) NOT NULL,
    Order_Status VARCHAR(30) NOT NULL,

    Product_Card_ID INT NOT NULL,
    Product_Name VARCHAR(200) NOT NULL,
    Product_Price DECIMAL(18,2) NOT NULL,

    Shipping_Date DATE NOT NULL,
    Shipping_Mode VARCHAR(30) NOT NULL,

    Order_Year INT NOT NULL,
    Order_Month_Number INT NOT NULL,
    Order_Month_Name VARCHAR(20) NOT NULL,
    Order_Quarter INT NOT NULL,
    Order_Day INT NOT NULL,
    Order_Week_Day VARCHAR(20) NOT NULL,

    Shipping_Delay INT NOT NULL,
    Shipping_Performance VARCHAR(30) NOT NULL,

    Shipping_Year INT NOT NULL,
    Shipping_Month_Name VARCHAR(20) NOT NULL,
    Shipping_Month_Number INT NOT NULL,

    Profit_Category VARCHAR(30) NOT NULL,
    Price_Category VARCHAR(30) NOT NULL
);

BULK INSERT SupplyChain
FROM 'E:\downlaod1\DataCleaning Eda SupplyChain Project.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0D0A',
    CODEPAGE = '65001',
    KEEPNULLS,
    TABLOCK
);

select * from SupplyChain;


--1. Dimension_Customer

SELECT DISTINCT
    Customer_ID,
    Customer_FullName,
    Customer_Segment,
    Customer_City,
    Customer_State,
    Customer_Country,
    Customer_Zipcode
INTO Dim_Customer
FROM SupplyChain;
      
-- 2. Dimension_Product

SELECT DISTINCT
    Product_Card_ID,
    Product_Name,
    Product_Price,
    Price_Category,
    Category_ID,
    Department_ID
INTO Dim_Product
FROM SupplyChain;

--drop table dim_product;

--3. Dimension_Category

SELECT DISTINCT
    Category_ID,
    Category_Name
INTO Dim_Category
FROM SupplyChain;

--4. Dimension Department

SELECT DISTINCT
    Department_ID,
    Department_Name
INTO Dim_Department
FROM SupplyChain;

--5. Dimension_Date

SELECT DISTINCT
    Order_Date,
    Order_Year,
    Order_Month_Number,
    Order_Month_Name,
    Order_Quarter,
    Order_Day,
    Order_Week_Day
INTO Dim_Date
FROM SupplyChain;

--6. Dimension_Shippping

SELECT DISTINCT
    Shipping_Mode,
    Shipping_Performance,
    Days_For_Shipping_Real,
    Days_For_Shipment_Scheduled
INTO Dim_Shipping
FROM SupplyChain;

--7. Fact_Orders

SELECT
    Order_Item_ID,
    Order_ID,

    Customer_ID,
    Product_Card_ID,
    Category_ID,
    Department_ID,

    Order_Date,
    Shipping_Date,

    Type,
    Market,

    Order_City,
    Order_State,
    Order_Country,
    Order_Region,

    Delivery_Status,
    Shipping_Mode,

    Sales,
    Sales_Per_Customer,

    Benefit_Per_Order,
    Order_Profit_Per_Order,

    Order_Item_Product_Price,
    Product_Price,

    Order_Item_Discount,
    Order_Item_Discount_Rate,

    Order_Item_Profit_Ratio,

    Order_Item_Total,

    Order_Item_Quantity,

    Shipping_Delay,

    Late_Delivery_Risk

INTO Fact_Orders
FROM SupplyChain;

--Adding Primary keys to Dimension table

ALTER TABLE Dim_Customer
ADD CONSTRAINT PK_Dim_Customer
PRIMARY KEY(Customer_ID);

ALTER TABLE Dim_Product
ADD CONSTRAINT PK_Dim_Product
PRIMARY KEY(Product_Card_ID);

ALTER TABLE Dim_Category
ADD CONSTRAINT PK_Dim_Category
PRIMARY KEY(Category_ID);

ALTER TABLE Dim_Department
ADD CONSTRAINT PK_Dim_Department
PRIMARY KEY(Department_ID);

ALTER TABLE Dim_Date
ADD CONSTRAINT PK_Dim_Date
PRIMARY KEY(Order_Date);

ALTER TABLE Fact_Orders
ADD CONSTRAINT PK_Fact_Orders
PRIMARY KEY(Order_Item_ID);

--ADDING FOREIGN KEYS

ALTER TABLE Fact_Orders
ADD CONSTRAINT FK_Customer
FOREIGN KEY(Customer_ID)
REFERENCES Dim_Customer(Customer_ID);

ALTER TABLE Fact_Orders
ADD CONSTRAINT FK_Product
FOREIGN KEY(Product_Card_ID)
REFERENCES Dim_Product(PRoduct_Card_ID);

ALTER TABLE Fact_Orders
ADD CONSTRAINT FK_Category
FOREIGN KEY(Category_ID)
REFERENCES Dim_Category(Category_ID);

ALTER TABLE Fact_Orders
ADD CONSTRAINT FK_Department
FOREIGN KEY(Department_ID)
REFERENCES Dim_Department(Department_ID);

ALTER TABLE Fact_Orders
ADD CONSTRAINT FK_Date
FOREIGN KEY(Order_Date)
REFERENCES Dim_Date(Order_Date);

SELECT * FROM DIM_CUSTOMER;
SELECT * FROM DIM_PRODUCT;
SELECT * FROM DIM_CATEGORY;
SELECT * FROM DIM_DEPARTMENT;
SELECT * FROM DIM_DATE;
SELECT * FROM DIM_SHIPPING;
SELECT * FROM FACT_ORDERS;


ALTER TABLE FACT_ORDERS
ADD SHIPPING_PERFORMANCE NVARCHAR(30),
    DAYS_FOR_SHIPPING_REAL INT,
    DAYS_FOR_SHIPMENT_SCHEDULED INT;

UPDATE F
SET
    F.SHIPPING_PERFORMANCE = S.SHIPPING_PERFORMANCE,
    F.DAYS_FOR_SHIPPING_REAL = S.DAYS_FOR_SHIPPING_REAL,
    F.DAYS_FOR_SHIPMENT_SCHEDULED = S.DAYS_FOR_SHIPMENT_SCHEDULED
FROM FACT_ORDERS F
INNER JOIN SUPPLYCHAIN S
    ON F.ORDER_ID = S.ORDER_ID;

-------------------------------------

--1.Find the top 10 revenue-generating products.

SELECT TOP 10
     PRODUCT_NAME,
	 SUM(SALES) TOTAL_REVENUE
FROM FACT_ORDERS F
JOIN 
DIM_PRODUCT P ON 
F.PRODUCT_CARD_ID=P.PRODUCT_CARD_ID
GROUP BY PRODUCT_NAME
ORDER BY TOTAL_REVENUE DESC;

--2.Find the top 10 profitable customers.

SELECT 
     TOP 10
	 CUSTOMER_FULLNAME,
	 SUM(ORDER_PROFIT_PER_ORDER) TOTAL_PROFIT
FROM FACT_ORDERS F 
JOIN 
DIM_CUSTOMER C ON
F.CUSTOMER_ID=C.CUSTOMER_ID
GROUP BY CUSTOMER_FULLNAME
ORDER BY TOTAL_PROFIT DESC;

--3.Find the category with the highest average profit.

SELECT TOP 1
      CATEGORY_NAME,
	  AVG(ORDER_PROFIT_PER_ORDER) AVG_PROFIT
FROM FACT_ORDERS F 
JOIN
DIM_CATEGORY C ON 
F.CATEGORY_ID=C.CATEGORY_ID
GROUP BY CATEGORY_NAME
ORDER BY AVG_PROFIT DESC;

--4. Find products whose average profit is above the average profit of their category.

WITH CTE AS (
SELECT 
      PRODUCT_NAME,
	  F.CATEGORY_ID,
	  AVG(ORDER_PROFIT_PER_ORDER) TOTAL_PROFIT
FROM FACT_ORDERS F
JOIN 
DIM_PRODUCT P ON 
F.PRODUCT_CARD_ID=P.PRODUCT_CARD_ID
GROUP BY PRODUCT_NAME,F.CATEGORY_ID
),
CTE1 AS (
SELECT 
     C.CATEGORY_ID,
     CATEGORY_NAME,
	 AVG(ORDER_PROFIT_PER_ORDER) AVG_PROFIT
FROM FACT_ORDERS F 
JOIN 
DIM_CATEGORY C ON
F.CATEGORY_ID=C.CATEGORY_ID
GROUP BY CATEGORY_NAME,C.CATEGORY_ID
)
SELECT 
     CATEGORY_NAME,
	 PRODUCT_NAME,
	 TOTAL_PROFIT,
	 AVG_PROFIT
FROM CTE C 
JOIN CTE1 C1 ON 
C.CATEGORY_ID=C1.CATEGORY_ID
WHERE TOTAL_PROFIT>AVG_PROFIT
ORDER BY TOTAL_PROFIT DESC;

--5. Find markets where the average discount amount is greater than the overall average discount amount.

SELECT
      MARKET,
	  AVG(ORDER_ITEM_DISCOUNT) AVG_DISCOUNT
FROM FACT_ORDERS
GROUP BY MARKET
HAVING AVG(ORDER_ITEM_DISCOUNT)>
        (
        SELECT AVG(ORDER_ITEM_DISCOUNT) OVERALL_AVG_DISCOUNT
		FROM FACT_ORDERS
		)
		
--6. Find the percentage of late deliveries for each shipping mode.

WITH CTE AS (
SELECT 
       SHIPPING_MODE,
	   COUNT(*) TOTAL_ORDERS,
	   SUM(CASE WHEN LATE_DELIVERY_RISK=1 THEN 1 ELSE 0 END) AS LATE_ORDERS
FROM FACT_ORDERS 
GROUP BY SHIPPING_MODE
)
SELECT 
      SHIPPING_MODE,
	  CAST(LATE_ORDERS*100.0/TOTAL_ORDERS AS DECIMAL(10,2)) AS PERCENTAGE_OF_LATE_DELIVERIES
FROM CTE 
	   
--7. Find the Top-selling product in every category.
WITH CTE AS (
SELECT 
     CATEGORY_NAME,
	 PRODUCT_NAME,
	 SUM(F.SALES) TOTAL_REVENUE,
	 ROW_NUMBER()OVER(PARTITION BY CATEGORY_NAME ORDER BY SUM(F.SALES) DESC) RN
FROM FACT_ORDERS F
JOIN DIM_PRODUCT P ON 
F.PRODUCT_CARD_ID=P.PRODUCT_CARD_ID
JOIN DIM_CATEGORY C ON 
F.CATEGORY_ID=C.CATEGORY_ID
GROUP BY CATEGORY_NAME,PRODUCT_NAME
)
SELECT 
      CATEGORY_NAME,
	  PRODUCT_NAME,
	  TOTAL_REVENUE
FROM CTE
WHERE RN=1

--8. Find customers who purchased products from more than one category.

SELECT 
      C.CUSTOMER_ID,
	  CUSTOMER_FULLNAME,
	  COUNT(DISTINCT F.CATEGORY_ID) TOTAL_C
FROM FACT_ORDERS F 
JOIN
DIM_CUSTOMER C ON 
F.CUSTOMER_ID=C.CUSTOMER_ID
JOIN 
DIM_PRODUCT P ON 
F.PRODUCT_CARD_ID=P.PRODUCT_CARD_ID
GROUP BY C.CUSTOMER_ID,CUSTOMER_FULLNAME
HAVING COUNT(DISTINCT F.CATEGORY_ID)>1
ORDER BY TOTAL_C DESC;

--9. Find the Top department in each market based on revenue.
WITH CTE AS (

SELECT
      DEPARTMENT_NAME,
	  MARKET,
	  SUM(SALES) TOTAL_REVENUE,
	  ROW_NUMBER()OVER(PARTITION BY MARKET ORDER BY SUM(SALES) DESC) RN
FROM FACT_ORDERS F 
JOIN 
DIM_DEPARTMENT D
ON F.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME,MARKET
)
SELECT 
      DEPARTMENT_NAME,MARKET,TOTAL_REVENUE
FROM CTE 
WHERE RN=1
ORDER BY TOTAL_REVENUE DESC;

--10. Rank Top customers based on total profit within each market.

WITH CTE AS (
SELECT 
     CUSTOMER_FULLNAME,
	 MARKET,
	 SUM(ORDER_PROFIT_PER_ORDER) TOTAL_PROFIT,
	 RANK()OVER(PARTITION BY MARKET ORDER BY SUM(ORDER_PROFIT_PER_ORDER) DESC) RN
FROM FACT_ORDERS F 
JOIN 
DIM_CUSTOMER C ON 
F.CUSTOMER_ID=C.CUSTOMER_ID
GROUP BY CUSTOMER_FULLNAME,MARKET
)
SELECT CUSTOMER_FULLNAME,MARKET,TOTAL_PROFIT
FROM CTE WHERE RN=1;

--11. Find the second highest revenue-generating product in each category.

SELECT 
      PRODUCT_NAME,
	  CATEGORY_NAME,
	  TOTAL_REVENUE
FROM (
SELECT 
      PRODUCT_NAME,
	  CATEGORY_NAME,
	  SUM(SALES) TOTAL_REVENUE,
	  DENSE_RANK()OVER(PARTITION BY CATEGORY_NAME ORDER BY SUM(SALES) DESC) DR
FROM FACT_ORDERS F
JOIN 
DIM_PRODUCT P ON 
F.PRODUCT_CARD_ID=P.PRODUCT_CARD_ID
JOIN DIM_CATEGORY C ON 
F.CATEGORY_ID=C.CATEGORY_ID
GROUP BY PRODUCT_NAME,CATEGORY_NAME)T
WHERE DR=2

--12. Identify the top 10% most profitable customers based on total profit.

WITH CUSTOMER_PROFIT AS
(
    SELECT
        C.CUSTOMER_ID,
        C.CUSTOMER_FULLNAME,
        SUM(F.ORDER_PROFIT_PER_ORDER) AS TOTAL_PROFIT
    FROM FACT_ORDERS F
    JOIN DIM_CUSTOMER C
        ON F.CUSTOMER_ID = C.CUSTOMER_ID
    GROUP BY
        C.CUSTOMER_ID,
        C.CUSTOMER_FULLNAME
),
CUSTOMER_RANK AS
(
    SELECT
        CUSTOMER_ID,
        CUSTOMER_FULLNAME,
        TOTAL_PROFIT,
        PERCENT_RANK() OVER
        (
            ORDER BY TOTAL_PROFIT DESC
        ) AS PROFIT_PERCENTILE
    FROM CUSTOMER_PROFIT
)

SELECT
    CUSTOMER_ID,
    CUSTOMER_FULLNAME,
    TOTAL_PROFIT,
    PROFIT_PERCENTILE
FROM CUSTOMER_RANK
WHERE PROFIT_PERCENTILE <= 0.10
ORDER BY TOTAL_PROFIT DESC;

-- 13. Divide customers into 4 revenue quartiles based on their total sales.

WITH CUSTOMER_SALES AS
(
    SELECT
        C.CUSTOMER_ID,
        C.CUSTOMER_FULLNAME,
        SUM(F.SALES) AS TOTAL_SALES
    FROM FACT_ORDERS F
    JOIN DIM_CUSTOMER C
        ON F.CUSTOMER_ID = C.CUSTOMER_ID
    GROUP BY
        C.CUSTOMER_ID,
        C.CUSTOMER_FULLNAME
)

SELECT
    CUSTOMER_ID,
    CUSTOMER_FULLNAME,
    TOTAL_SALES,
    NTILE(4) OVER(ORDER BY TOTAL_SALES DESC) AS REVENUE_QUARTILE
FROM CUSTOMER_SALES;

--14. Calculate the Month-over-Month (MoM) Sales Growth for each market.

WITH CTE AS (      
      SELECT 
	        MONTH(ORDER_DATE) CURRENT_MONTH,
			MARKET,
			SUM(SALES) TOTAL_SALES
	  FROM FACT_ORDERS
	  GROUP BY MONTH(ORDER_DATE),MARKET
	  ),
	  CTE1 AS (
	  SELECT
	        MARKET,
	        CURRENT_MONTH,
			TOTAL_SALES,
			LAG(TOTAL_SALES)OVER(PARTITION BY MARKET ORDER BY CURRENT_MONTH) PREV_MONTH_SALES
	  FROM CTE 
	  )
	  SELECT 
	       MARKET,
		   CURRENT_MONTH,
		   TOTAL_SALES,
		   PREV_MONTH_SALES,
		   CAST((TOTAL_SALES-PREV_MONTH_SALES)*100.0/PREV_MONTH_SALES AS DECIMAL(10,2)) AS MOM
	  FROM CTE1
			
--15. Display each month's sales along with the next month's sales for every market.
	
	WITH CTE AS (
	          SELECT 
			        MARKET,
			        ORDER_MONTH_NUMBER,
					SUM(SALES) TOTAL_SALES
			  FROM DIM_DATE D
			  JOIN
			  FACT_ORDERS F ON 
			  D.ORDER_DATE=F.ORDER_DATE
			  GROUP BY ORDER_MONTH_NUMBER,MARKET
			  ),
	 CTE1 AS (
			   SELECT  
					 MARKET,
					 ORDER_MONTH_NUMBER,
					 TOTAL_SALES,
					 LEAD(TOTAL_SALES)OVER(PARTITION BY MARKET ORDER BY ORDER_MONTH_NUMBER) NEXT_SALES
		       FROM CTE 
				)
				SELECT 
				      MARKET,
					  ORDER_MONTH_NUMBER,
					  TOTAL_SALES,
					  NEXT_SALES
				FROM CTE1
	
--16. Calculate the cumulative monthly sales for each market.

WITH CTE AS (
SELECT 
      MARKET,
	  ORDER_MONTH_NAME,
	  ORDER_MONTH_NUMBER,
	  SUM(SALES) TOTAL_SALES
FROM FACT_ORDERS F
JOIN DIM_DATE D ON 
F.ORDER_DATE=D.ORDER_DATE
GROUP BY MARKET,ORDER_MONTH_NAME,ORDER_MONTH_NUMBER
)
SELECT 
      MARKET,
	  ORDER_MONTH_NAME,
	  TOTAL_SALES,
	  SUM(TOTAL_SALES)OVER(PARTITION BY MARKET ORDER BY ORDER_MONTH_NUMBER) CUMM_SALES
FROM CTE;

--17. Calculate the 3-month moving average of sales for each market.

WITH CTE AS (
SELECT 
      MARKET,
	  ORDER_MONTH_NAME,
	  ORDER_MONTH_NUMBER,
	  SUM(SALES) TOTAL_SALES
FROM FACT_ORDERS F
JOIN DIM_DATE D ON 
F.ORDER_DATE=D.ORDER_DATE
GROUP BY MARKET,ORDER_MONTH_NAME,ORDER_MONTH_NUMBER
)
SELECT 
      MARKET,
	  ORDER_MONTH_NAME,
	  TOTAL_SALES,
	  CAST(AVG(TOTAL_SALES)OVER(PARTITION BY MARKET ORDER BY ORDER_MONTH_NUMBER 
	                     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)AS DECIMAL(10,2)) AVG_3MONTH_SALES
FROM CTE;
      
--18. Find customers whose total profit is greater than the average profit of customers in their own market.

WITH CTE AS (
        SELECT 
		      C.CUSTOMER_ID,
		      MARKET,
			  CUSTOMER_FULLNAME,
			  SUM(ORDER_PROFIT_PER_ORDER) TOTAL_PROFIT
		FROM FACT_ORDERS F 
		JOIN
		DIM_CUSTOMER C ON
		F.CUSTOMER_ID=C.CUSTOMER_ID
		GROUP BY C.CUSTOMER_ID,MARKET,CUSTOMER_FULLNAME
	)
	 SELECT
	       C1.CUSTOMER_FULLNAME,
		   C1.MARKET,
		   C1.TOTAL_PROFIT
	FROM CTE C1
	WHERE C1.TOTAL_PROFIT>(SELECT 
							 AVG(C2.TOTAL_PROFIT) AVG_PROFIT
						FROM CTE C2
						WHERE C2.MARKET=C1.MARKET);

--19. Find customers who have purchased products from the 'Electronics' category using EXISTS.

SELECT
    C.CUSTOMER_ID,
    C.CUSTOMER_FULLNAME
FROM DIM_CUSTOMER C
WHERE EXISTS
(
    SELECT 1
    FROM FACT_ORDERS F
    JOIN DIM_CATEGORY CA
        ON F.CATEGORY_ID = CA.CATEGORY_ID
    WHERE F.CUSTOMER_ID = C.CUSTOMER_ID
      AND CA.CATEGORY_NAME = 'ELECTRONICS'
);

--20. Identify customers who placed orders on consecutive days.

WITH CTE AS (
SELECT 
      C.CUSTOMER_ID,
      CUSTOMER_FULLNAME,
	  ORDER_DATE,
	  ROW_NUMBER()OVER(PARTITION BY C.CUSTOMER_ID ORDER BY ORDER_DATE) RN
FROM FACT_ORDERS F
JOIN 
DIM_CUSTOMER C ON
F.CUSTOMER_ID=C.CUSTOMER_ID
),
CTE1 AS (
SELECT 
      CUSTOMER_ID,
      CUSTOMER_FULLNAME,
	  ORDER_DATE,
	  DATEADD(DAY,-RN,ORDER_DATE) GRP
FROM CTE
)
SELECT 
      CUSTOMER_ID,
      CUSTOMER_FULLNAME,
	  COUNT(*) DAYS
FROM CTE1
GROUP BY CUSTOMER_ID,CUSTOMER_FULLNAME,GRP
HAVING COUNT(*)>1




/*
=========================================
Create Reporting Views
Project : Supply Chain Analytics
Author  : Your Name
=========================================
*/

---------------------------------------------------------
-- View 1 : Monthly Sales
---------------------------------------------------------

CREATE VIEW VW_MONTHLYSALES
AS
SELECT
    D.ORDER_YEAR,
    D.ORDER_MONTH_NAME,
    F.MARKET,
    SUM(F.SALES) AS TOTAL_SALES,
    SUM(F.ORDER_PROFIT_PER_ORDER) AS TOTAL_PROFIT
FROM FACT_ORDERS F
JOIN DIM_DATE D
    ON F.ORDER_DATE = D.ORDER_DATE
GROUP BY
    D.ORDER_YEAR,
    D.ORDER_MONTH_NAME,
    F.MARKET;
GO

SELECT * FROM VW_MONTHLYSALES;
---------------------------------------------------------
-- View 2 : Customer Performance
---------------------------------------------------------

CREATE VIEW VW_CUSTOMERPERFORMANCE
AS
SELECT
    C.CUSTOMER_ID,
    C.CUSTOMER_FULLNAME,
    SUM(F.SALES) AS TOTAL_SALES,
    SUM(F.ORDER_PROFIT_PER_ORDER) AS TOTAL_PROFIT
FROM FACT_ORDERS F
JOIN DIM_CUSTOMER C
    ON F.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY
    C.CUSTOMER_ID,
    C.CUSTOMER_FULLNAME;
GO

SELECT * FROM VW_CUSTOMERPERFORMANCE;


/*
=========================================
CREATE INDEXES
PROJECT : SUPPLY CHAIN ANALYTICS
=========================================
*/

---------------------------------------------------------
-- CUSTOMER INDEX
---------------------------------------------------------

CREATE INDEX IX_FACTORDERS_CUSTOMER
ON FACT_ORDERS(CUSTOMER_ID);
GO

---------------------------------------------------------
-- PRODUCT INDEX
---------------------------------------------------------

CREATE INDEX IX_FACTORDERS_PRODUCT
ON FACT_ORDERS(PRODUCT_CARD_ID);
GO

---------------------------------------------------------
-- DATE INDEX
---------------------------------------------------------

CREATE INDEX IX_FACTORDERS_ORDERDATE
ON FACT_ORDERS(ORDER_DATE);
GO

---------------------------------------------------------
-- MARKET INDEX
---------------------------------------------------------

CREATE INDEX IX_FACTORDERS_MARKET
ON FACT_ORDERS(MARKET);
GO

/*
=========================================
Stored Procedures
Project : Supply Chain Analytics
=========================================
*/

--1. usp_Load_DimCustomer

CREATE OR ALTER PROCEDURE usp_Load_DimCustomer
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO Dim_Customer
    (
        Customer_ID,
        Customer_FullName,
        Customer_Segment,
        Customer_City,
        Customer_State,
        Customer_Country,
        Customer_Zipcode
    )

    SELECT DISTINCT
        S.Customer_ID,
        S.Customer_FullName,
        S.Customer_Segment,
        S.Customer_City,
        S.Customer_State,
        S.Customer_Country,
        S.Customer_Zipcode
    FROM SupplyChain S
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Dim_Customer D
        WHERE D.Customer_ID = S.Customer_ID
    );

END
GO


--2. usp_Load_DimCategory

CREATE OR ALTER PROCEDURE usp_Load_DimCategory
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO Dim_Category
    (
        Category_ID,
        Category_Name
    )

    SELECT DISTINCT
        S.Category_ID,
        S.Category_Name
    FROM SupplyChain S
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Dim_Category D
        WHERE D.Category_ID = S.Category_ID
    );

END
GO

--3. usp_Load_DimDepartment

CREATE OR ALTER PROCEDURE usp_Load_DimDepartment
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO Dim_Department
    (
        Department_ID,
        Department_Name
    )

    SELECT DISTINCT
        S.Department_ID,
        S.Department_Name
    FROM SupplyChain S
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Dim_Department D
        WHERE D.Department_ID = S.Department_ID
    );

END
GO


--4. usp_Load_DimProduct

CREATE OR ALTER PROCEDURE usp_Load_DimProduct
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO Dim_Product
    (
        Product_Card_ID,
        Product_Name,
        Product_Price,
        Price_Category,
        Category_ID,
        Department_ID
    )

    SELECT DISTINCT
        S.Product_Card_ID,
        S.Product_Name,
        S.Product_Price,
        S.Price_Category,
        S.Category_ID,
        S.Department_ID
    FROM SupplyChain S
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Dim_Product D
        WHERE D.Product_Card_ID = S.Product_Card_ID
    );

END
GO


--5. usp_Load_DimDate

CREATE OR ALTER PROCEDURE usp_Load_DimDate
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO Dim_Date
    (
        Order_Date,
        Order_Year,
        Order_Quarter,
        Order_Month_Number,
        Order_Month_Name,
        Order_Day,
        Order_Week_Day
    )

    SELECT DISTINCT
        S.Order_Date,
        S.Order_Year,
        S.Order_Quarter,
        S.Order_Month_Number,
        S.Order_Month_Name,
        S.Order_Day,
        S.Order_Week_Day
    FROM SupplyChain S
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Dim_Date D
        WHERE D.Order_Date = S.Order_Date
    );

END
GO


--6. usp_Load_FactOrders

CREATE OR ALTER PROCEDURE usp_Load_FactOrders
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO Fact_Orders
    (
        Order_ID,
        Customer_ID,
        Product_Card_ID,
        Category_ID,
        Department_ID,
        Order_Date,
        Shipping_Date,
        Sales,
        Order_Profit_Per_Order,
        Market,
        Shipping_Mode,
        Late_Delivery_Risk,
		Shipping_performance,
		Days_For_Shipping_Real,
		Days_For_Shipment_Scheduled
    )

    SELECT
        S.Order_ID,
        S.Customer_ID,
        S.Product_Card_ID,
        S.Category_ID,
        S.Department_ID,
        S.Order_Date,
        S.Shipping_Date,
        S.Sales,
        S.Order_Profit_Per_Order,
        S.Market,
        S.Shipping_Mode,
        S.Late_Delivery_Risk,
		S.Shipping_performance,
		S.Days_For_Shipping_Real,
		S.Days_For_Shipment_Scheduled
    FROM SupplyChain S
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Fact_Orders F
        WHERE F.Order_ID = S.Order_ID
    );

END
GO


--7. Master Procedure

CREATE OR ALTER PROCEDURE usp_Load_SupplyChainDW
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        EXEC usp_Load_DimCustomer;
        EXEC usp_Load_DimCategory;
        EXEC usp_Load_DimDepartment;
        EXEC usp_Load_DimProduct;
        EXEC usp_Load_DimDate;
        EXEC usp_Load_FactOrders;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO

