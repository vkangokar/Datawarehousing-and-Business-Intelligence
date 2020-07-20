USE neu_workshops    -- specify database
GO

-- Rick Sherman
-- INFO7370
-- for Data Integration Lesson 01
-- 2019-02-21
-- SQL Server

--drop table DimProduct_All;

CREATE TABLE DimProduct_All
-- This only includes all Products even those that are not sold and are not part of a hierarchy
(
   ProductSK int IDENTITY(1,1) NOT NULL,           -- SK
   ProductID int  NOT NULL,                        -- NK

   -- products that are not sold have no subcat or cat
   ProductSubcategoryID int NULL,
   ProductSubcategoryName nvarchar(50) NULL,       -- Name

   ProductCategoryID int NULL,
   ProductCategoryName nvarchar(50) NULL,          -- Name

   ProductName nvarchar(50) NOT NULL,              -- Name
   ProductNumber nvarchar(25) NOT NULL,
   MakeFlag int NOT NULL,                         -- Flag
   FinishedGoodsFlag int NOT NULL,                 -- Flag
   Color nvarchar(15) NULL,
   SafetyStockLevel int NOT NULL,
   ReorderPoint int NOT NULL,
   Size nvarchar(5) NULL,
   SizeUnitMeasureCode nchar(3) NULL,
   WeightUnitMeasureCode nchar(3) NULL,
   Weight decimal(8, 2) NULL,
   DaysToManufacture int NOT NULL,
   ProductLine nchar(2) NULL,
   Class nchar(2) NULL,
   Style nchar(2) NULL,
   SellStartDate datetime NOT NULL,
   SellEndDate datetime NULL,
   DiscontinuedDate datetime NULL,

   StandardCost numeric(15,2)  NULL,   -- was NOT NULL,
   ListPrice numeric(15,2)  NULL,   -- was NOT NULL,

   Product_ModifiedDate datetime NULL,
   ProductSubcategory_ModifiedDate datetime NULL,
   ProductCategory_ModifiedDate datetime NULL,

   SOR_ID                    int NULL default -99,
   SOR_LoadDate       datetime NULL,
   SOR_UpdateDate    datetime NULL,

   DI_JobID                 nvarchar(20) NULL,
   DI_JobName           nvarchar(80) NULL,
   DI_ToolName           nvarchar(80) NULL,
   DI_Create_Date      datetime NOT NULL DEFAULT getdate(),
   DI_Modified_Date datetime NOT NULL DEFAULT getdate(),
 
PRIMARY KEY CLUSTERED (ProductSK ASC) 
);

--drop  TABLE DimProduct_Sold; 

CREATE TABLE DimProduct_Sold
-- This only includes Products that are sold and are part of a hierarchy
(
   ProductSK int IDENTITY(1,1) NOT NULL,           -- SK
   ProductID int  NOT NULL,                        -- NK

   ProductSubcategoryID int NOT NULL,
   ProductSubcategoryName nvarchar(50) NOT NULL,   -- from Production.ProductSubcategory

   ProductCategoryID int NOT NULL,                 -- from Production.ProductCategory
   ProductCategoryName nvarchar(50) NOT NULL,      -- from Production.ProductCategory

   ProductName nvarchar(50) NOT NULL,              
   ProductNumber nvarchar(25) NOT NULL,
   MakeFlag int NOT NULL,                         -- 1 Manufactured 0 Purchased
   FinishedGoodsFlag int NOT NULL,                 -- 1 Salable 0 Not Sold
   Color nvarchar(15) NULL,
   SafetyStockLevel int NOT NULL,
   ReorderPoint int NOT NULL,
   Size nvarchar(5) NULL,
   SizeUnitMeasureCode nchar(3) NULL,
   WeightUnitMeasureCode nchar(3) NULL,
   Weight decimal(8, 2) NULL,
   DaysToManufacture int NOT NULL,
   ProductLine nchar(2) NULL,
   Class nchar(2) NULL,
   Style nchar(2) NULL,
   SellStartDate datetime NOT NULL,
   SellEndDate datetime NULL,
   DiscontinuedDate datetime NULL,

   StandardCost numeric(15,2) NOT NULL,
   ListPrice numeric(15,2) NOT NULL,

   Product_ModifiedDate datetime NULL,
   Subcategory_ModifiedDate datetime NULL,
   Category_ModifiedDate datetime NULL,

   SOR_ID          int NULL default -99,
   SOR_LoadDate    datetime NULL,
   SOR_UpdateDate  datetime NULL,

   DI_JobID                 nvarchar(20) NULL,
   DI_JobName           nvarchar(80) NULL,
   DI_ToolName           nvarchar(80) NULL,
   DI_Create_Date      datetime NOT NULL DEFAULT getdate(),
   DI_Modified_Date datetime NOT NULL DEFAULT getdate(),

PRIMARY KEY CLUSTERED (ProductSK ASC) 
);


/* ----------------------------------------------------------------------------------------------- */

--drop  TABLE DimProduct_Rejects;
CREATE TABLE DimProduct_Rejects

(
   ProductRejectSK int IDENTITY(1,1) NOT NULL,        -- SK
   ProductID int  NOT NULL,                        

   -- Products that are not sold have no subcat or cat
   ProductSubcategoryID int NULL,                -- NULL to support ref int problems
   ProductSubcategoryName nvarchar(50) NULL,     -- NULL to support ref int problems   

   ProductCategoryID int NULL,                   -- NULL to support ref int problems
   ProductCategoryName nvarchar(50) NULL,        -- NULL to support ref int problems         

   ProductName nvarchar(50) NOT NULL,              
   ProductNumber nvarchar(25) NOT NULL,
   MakeFlag int NOT NULL,                         
   FinishedGoodsFlag int NOT NULL,                 
   Color nvarchar(15) NULL,
   SafetyStockLevel int NOT NULL,
   ReorderPoint int NOT NULL,
   Size nvarchar(5) NULL,
   SizeUnitMeasureCode nchar(3) NULL,
   WeightUnitMeasureCode nchar(3) NULL,
   Weight decimal(8, 2) NULL,
   DaysToManufacture int NOT NULL,
   ProductLine nchar(2) NULL,
   Class nchar(2) NULL,
   Style nchar(2) NULL,
   SellStartDate datetime NOT NULL,
   SellEndDate datetime NULL,
   DiscontinuedDate datetime NULL,

   StandardCost numeric(15,2)  NULL,                   -- NULL to support ref int problems
   ListPrice numeric(15,2)  NULL,                      -- NULL to support ref int problems

   Product_ModifiedDate datetime NULL,
   Subcategory_ModifiedDate datetime NULL,
   Category_ModifiedDate datetime NULL,
 
   SOR_ID          int NULL default -99,
   SOR_LoadDate    datetime NULL,
   SOR_UpdateDate  datetime NULL,

   DI_RejectReason  nvarchar(80) NULL default 'No Reason Given',

   DI_JobID                 nvarchar(20) NULL,
   DI_JobName           nvarchar(80) NULL,
   DI_ToolName           nvarchar(80) NULL,
   DI_Create_Date      datetime NOT NULL DEFAULT getdate(),
   DI_Modified_Date datetime NOT NULL DEFAULT getdate(),

PRIMARY KEY CLUSTERED (ProductRejectSK ASC) 
);

-----
--drop TABLE ScrapReason
;
CREATE TABLE ScrapReason(
	ScrapReasonID int  NOT NULL,
	ScrapReasonName nvarchar(50)  NOT NULL,
	ModifiedDate datetime NOT NULL,
PRIMARY KEY  (ScrapReasonID)
) 
;
