SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--<<<<<<<<<<<<<<<<<<<<-------------------BUILDING WORKING TABLE----------------------->>>>>>>>>>>>>>>>>>>>>>--


-----------------------------------------------------------
-----------------------------------------------------------
-- AUTHOR:
-- CREATE DATE:
-- DESCRIPTION: RAW -> WRK
-- MOD DATE:
-----------------------------------------------------------
-----------------------------------------------------------

ALTER PROC  [dbo].[__tmpl__BLD_WRK_TableName]


As 
BEGIN


-----------------------------------------------------------
-- Drop WORKING TABLE IF Exists
-----------------------------------------------------------
IF OBJECT_ID('WRK_TableName') IS NOT NULL 
DROP TABLE [WRK_TableName]
-----------------------------------------------------------
-- Table [WRK_TableName] Deleted
-----------------------------------------------------------



-----------------------------------------------------------
-- CREATE WORKING TABLE
-----------------------------------------------------------
CREATE TABLE [DatabaseName].[dbo].[WRK_TableName](
   
    Rownumber INT IDENTITY(1,1)
    ,CustomerID VARCHAR(100)
    ,City VARCHAR(1000)
    ,ZipCode VARCHAR(100)
    ,Gender VARCHAR(10)
    ,Age FLOAT
)
-----------------------------------------------------------
-- Table [WRK_TableName] Created
-----------------------------------------------------------



-----------------------------------------------------------
-- TRUNCATE WORKING TABLE
-----------------------------------------------------------
TRUNCATE TABLE [DatabaseName].[dbo].[WRK_TableName]
SELECT *  FROM [DatabaseName].[dbo].[WRK_TableName]
-----------------------------------------------------------
-- Table [WRK_TableName] Truncated
-----------------------------------------------------------



-----------------------------------------------------------
-- INSERT from RAW_TableName_YYYYMMDD INTO WRK_TableName
-----------------------------------------------------------
INSERT INTO [DatabaseName].[dbo].[WRK_TableName](
    CustomerID
    ,City
    ,ZipCode
    ,Gender
    ,Age
    ,[OrderDate]
    ,[Units]
    ,[UnitPrice]
)
SELECT 
       RIGHT('0000000'+[CustomerID], 7)  -- Adding Leading Zeros
      ,[City]
      ,[ZipCode]
      ,[Gender]
      ,[Age]
      ,CONVERT(DATE, [OrderDate], 20)  -- Canonical Date Format
      ,CAST([Units] AS INT)
      ,CAST([UnitPrice] AS FLOAT)
  FROM [DatabaseName].[dbo].[RAW_TableName_YYYYMMDD]
-----------------------------------------------------------
-- (X rows affected)
-----------------------------------------------------------



--<<<<<<<<<<<<<<<<<<<<-------------------QUALITY ASSURANCE----------------------->>>>>>>>>>>>>>>>>>>>>>--


-----------------------------------------------------------
-----------------------------------------------------------
-- AUTHOR: 
-- CREATE DATE: 
-- DESCRIPTION: QUALITY ASSURANCE
-- MOD DATE:
-----------------------------------------------------------
-----------------------------------------------------------



-----------------------------------------------------------
-- COUNT Number of Rows
-----------------------------------------------------------
SELECT COUNT(*)  FROM [DatabaseName].[dbo].[WRK_TableName]
-----------------------------------------------------------
-- Number of Rows: X
-----------------------------------------------------------



-----------------------------------------------------------
-- SELECT
-----------------------------------------------------------
SELECT *  FROM [DatabaseName].[dbo].[WRK_TableName]
-----------------------------------------------------------
-- X Rows 
-----------------------------------------------------------



--<<<<<<<<<<<<<<<<<<<<-------------------BUILDING DRIVING TABLE----------------------->>>>>>>>>>>>>>>>>>>>>>--


-----------------------------------------------------------
-----------------------------------------------------------
-- AUTHOR:
-- CREATE DATE:
-- DESCRIPTION: WRK -> DRV
-- COMBINING TABLES: [WRK_FirstTableName] & [WRK_SecondTableName]
-- MOD DATE:
-----------------------------------------------------------
-----------------------------------------------------------



-----------------------------------------------------------
-- DROP COMBINED TABE
-----------------------------------------------------------
/*
DROP TABLE [DRV_CombinedTableName]
*/
-----------------------------------------------------------
-- 
-----------------------------------------------------------



-----------------------------------------------------------
-- JOIN
-----------------------------------------------------------
SELECT *  FROM [DatabaseName].[dbo].[WRK_FirstTableName] AS A -- Rename WRK_FirstTableName
LEFT JOIN [DatabaseName].[dbo].[WRK_SecondTableName] AS B  -- Rename WRK_SecondTableName
ON A.CustomerID = B.CustomerID  -- Change CustomerID
-----------------------------------------------------------
-- X Rows Displayed
-----------------------------------------------------------



-----------------------------------------------------------
-- JOIN (Specifying Columns)
-----------------------------------------------------------
SELECT *
    --A.CustomerID
    --A.Gender
    --B.Units * B.UnitPrice as Revenue
FROM [DatabaseName].[dbo].[WRK_FirstTableName] AS A -- Rename WRK_FirstTableName
LEFT JOIN [DatabaseName].[dbo].[WRK_SecondTableName] AS B  -- Rename WRK_SecondTableName
ON A.CustomerID = B.CustomerID  -- Change CustomerID
-----------------------------------------------------------
-- X Rows Displayed
-----------------------------------------------------------



END

GO
