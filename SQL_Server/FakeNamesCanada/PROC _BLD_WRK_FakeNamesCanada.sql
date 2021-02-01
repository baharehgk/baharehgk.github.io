SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
-----------------------------------------------------------
-- AUTHOR: Bahar Gk
-- CREATE DATE: 20210131
-- DESCRIPTION: RAW -> WRK
-- MOD DATE:
-----------------------------------------------------------
-----------------------------------------------------------

ALTER PROC  [dbo].[BLD_WRK_FakeNamesCanada]


As 
BEGIN


-----------------------------------------------------------
-- Drop WORKING TABLE IF Exists
-----------------------------------------------------------
IF OBJECT_ID('WRK_FakeNamesCanada') IS NOT NULL 
DROP TABLE [WRK_FakeNamesCanada]
-----------------------------------------------------------
-- Table [WRK_FakeNamesCanada] Deleted
-----------------------------------------------------------



-----------------------------------------------------------
-- CREATE WORKING TABLE
-----------------------------------------------------------
CREATE TABLE [DATASCIENCESCHOOLS].[dbo].[WRK_FakeNamesCanada](
   
    [rowNumber]         VARCHAR(100)
    ,[Gender]           VARCHAR(10)
    ,[GivenName]        VARCHAR(1000)
    ,[Surname]          VARCHAR(1000)
    ,[StreetAddress]    VARCHAR(1000)
    ,[City]             VARCHAR(1000)
    ,[ZipCode]          VARCHAR(7)
    ,[CountryFull]      VARCHAR(100)
    ,[Birthday]         DATE
    ,[Balance]          FLOAT
    ,[InterestRate]     FLOAT
)
-----------------------------------------------------------
-- Table [WRK_FakeNamesCanada] Created
-----------------------------------------------------------



-----------------------------------------------------------
-- TRUNCATE WORKING TABLE
-----------------------------------------------------------
TRUNCATE TABLE [DATASCIENCESCHOOLS].[dbo].[WRK_FakeNamesCanada]
SELECT *  FROM [DATASCIENCESCHOOLS].[dbo].[WRK_FakeNamesCanada]
-----------------------------------------------------------
-- Table [WRK_FakeNamesCanada] Truncated
-----------------------------------------------------------



-----------------------------------------------------------
-- INSERT from RAW_FakeNamesCanada_20210131 INTO WRK_FakeNamesCanada
-----------------------------------------------------------
INSERT INTO [DATASCIENCESCHOOLS].[dbo].[WRK_FakeNamesCanada](
    [rowNumber]
    ,[Gender]
    ,[GivenName]
    ,[Surname]
    ,[StreetAddress]
    ,[City]
    ,[ZipCode]
    ,[CountryFull]
    ,[Birthday]
    ,[Balance]
    ,[InterestRate]
)
SELECT 
    [rowNumber]
    ,[Gender]
    ,[GivenName]
    ,[Surname]
    ,[StreetAddress]
    ,[City]
    ,[ZipCode]
    ,[CountryFull]
    ,[Birthday]
    ,CAST([Balance] AS FLOAT)
    ,CAST([InterestRate] AS FLOAT)
  FROM [DATASCIENCESCHOOLS].[dbo].[RAW_FakeNamesCanada_20210131]
-- FILTERS
WHERE ISNUMERIC([Balance]) = 1     
AND LEN([ZipCode]) <= 7            
AND ISDATE([Birthday] ) = 1    
AND CAST([Balance] AS FLOAT) > 0  
AND [ZipCode] LIKE '___ ___'

-----------------------------------------------------------
-- 11 Rows Excluded from [Balance]
-- 6  Rows Excluded from [ZipCode]
-- 3  Rows Excluded from [Birthday]
-- 1 Row in common between [Birthday] & [Balance]
-- (199981 rows affected)
-- 199981 + 11 + 6 + 3 - 1 = 200000 -> VERIFIED
-----------------------------------------------------------

--<<<<<<<<<<<<<<<<<<<<-------------------Quality Assurance----------------------->>>>>>>>>>>>>>>>>>>>>>--


-----------------------------------------------------------
-----------------------------------------------------------
-- AUTHOR: Bahar GK
-- CREATE DATE: 20210201
-- DESCRIPTION: QUALITY ASSURANCE
-- MOD DATE:
-----------------------------------------------------------
-----------------------------------------------------------


-----------------------------------------------------------
-- SELECT NON NUMERIC [BALANCE] OR [Balance] < 0
-----------------------------------------------------------
SELECT *  FROM [DATASCIENCESCHOOLS].[dbo].[RAW_FakeNamesCanada_20210131]
WHERE ISNUMERIC([Balance] ) <> 1
OR CAST([Balance] AS FLOAT) < 0
-----------------------------------------------------------
-- 11 Rows [BALANCE]: NON NUMERIC [BALANCE] OR [Balance] < 0
-----------------------------------------------------------


-----------------------------------------------------------
-- SELECT [ZIPCODE] OVER 7 CHARACTERS OR NOT LIKE '___ ___'
-----------------------------------------------------------
SELECT *  FROM [DATASCIENCESCHOOLS].[dbo].[RAW_FakeNamesCanada_20210131]
WHERE LEN([ZipCode] ) > 7
OR [ZipCode] NOT LIKE '___ ___'
-----------------------------------------------------------
-- 6 Rows [ZIPCODE]: OVER 7 CHARACTERS OR NOT LIKE '___ ___'
-----------------------------------------------------------


-----------------------------------------------------------
-- SELECT NON DATE [Birthday]
-----------------------------------------------------------
SELECT *  FROM [DATASCIENCESCHOOLS].[dbo].[RAW_FakeNamesCanada_20210131]
WHERE ISDATE([Birthday]) <> 1
-----------------------------------------------------------
-- 3 Rows [Birthday]: NOT DATE 
-----------------------------------------------------------


----------------------------------------------------------
-- SELECT COMMON ROWS 
-----------------------------------------------------------
SELECT *  FROM [DATASCIENCESCHOOLS].[dbo].[RAW_FakeNamesCanada_20210131]
WHERE (ISNUMERIC([Balance] ) <> 1
OR CAST([Balance] AS FLOAT) < 0)
AND ISDATE([Birthday] ) <> 1
-- 1 Common Row

SELECT *  FROM [DATASCIENCESCHOOLS].[dbo].[RAW_FakeNamesCanada_20210131]
WHERE (ISNUMERIC([Balance] ) <> 1
OR CAST([Balance] AS FLOAT) < 0)
AND  (LEN([ZipCode] ) > 7
OR [ZipCode] NOT LIKE '___ ___')
-- 0 COMMON Row

SELECT *  FROM [DATASCIENCESCHOOLS].[dbo].[RAW_FakeNamesCanada_20210131]
WHERE ISDATE([Birthday] ) <> 1
AND (LEN([ZipCode] ) > 7
OR [ZipCode] NOT LIKE '___ ___')
-- 0 COMMON Row
-----------------------------------------------------------
-- Total 1 Row in Common between [Balance] & [Birthday]
-----------------------------------------------------------






-----------------------------------------------------------
-- COUNT Number of Rows
-----------------------------------------------------------
SELECT COUNT(*)  FROM [DATASCIENCESCHOOLS].[dbo].[WRK_FakeNamesCanada]
-----------------------------------------------------------
-- Number of Rows: 199986
-----------------------------------------------------------


-----------------------------------------------------------
-- SELECT
-----------------------------------------------------------
SELECT *  FROM [DATASCIENCESCHOOLS].[dbo].[WRK_FakeNamesCanada]
-----------------------------------------------------------
-- 199986 Rows Displayed
-----------------------------------------------------------



END


GO
