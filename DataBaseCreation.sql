CREATE DATABASE AdventureWorksDW_Project;
GO

USE AdventureWorksDW_Project;
GO

/* =========================================================
   DIMENSION TABLES
   ========================================================= */

CREATE TABLE dbo.DIM_DATE (
    DateKey         INT         NOT NULL PRIMARY KEY,   -- e.g. 20250131, and -1 for Unknown
    FullDate        DATE        NOT NULL UNIQUE,
    DayNum          TINYINT     NOT NULL,
    MonthNum        TINYINT     NOT NULL,
    MonthName       VARCHAR(20) NOT NULL,
    QuarterNum      TINYINT     NOT NULL,
    YearNum         SMALLINT    NOT NULL,
    WeekdayName     VARCHAR(20) NOT NULL,
    IsWeekend       BIT         NOT NULL,
    WeekNumber      TINYINT     NOT NULL,
    FiscalYear      SMALLINT    NOT NULL,
    FiscalQuarter   TINYINT     NOT NULL
);
GO

CREATE TABLE dbo.DIM_TERRITORY (
    TerritoryKey        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TerritoryID         INT NOT NULL,
    TerritoryName       NVARCHAR(50) NOT NULL,
    CountryRegionCode   NVARCHAR(3) NOT NULL,
    RegionGroup         NVARCHAR(50) NOT NULL,
    CONSTRAINT UQ_DIM_TERRITORY_TerritoryID UNIQUE (TerritoryID)
);
GO

CREATE TABLE dbo.DIM_PROMOTION (
    PromotionKey            INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    SpecialOfferID          INT NOT NULL,
    PromotionDescription    NVARCHAR(255) NOT NULL,
    DiscountPct             DECIMAL(8,4) NOT NULL,
    PromotionType           NVARCHAR(50) NOT NULL,
    PromotionCategory       NVARCHAR(50) NOT NULL,
    StartDate               DATE NOT NULL,
    EndDate                 DATE NULL,
    MinQty                  INT NOT NULL,
    MaxQty                  INT NULL,
    CONSTRAINT UQ_DIM_PROMOTION_SpecialOfferID UNIQUE (SpecialOfferID)
);
GO

CREATE TABLE dbo.DIM_PRODUCT (
    ProductKey          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductID           INT NOT NULL,
    ProductName         NVARCHAR(100) NOT NULL,
    ProductNumber       NVARCHAR(25) NOT NULL,
    Color               NVARCHAR(15) NOT NULL,
    Size                NVARCHAR(10) NOT NULL,
    Class               NVARCHAR(5) NOT NULL,
    Style               NVARCHAR(5) NOT NULL,
    ProductLine         NVARCHAR(5) NOT NULL,
    DaysToManufacture   INT NOT NULL,
    StandardCost        DECIMAL(18,4) NOT NULL,
    ListPrice           DECIMAL(18,4) NOT NULL,
    SubcategoryName     NVARCHAR(50) NOT NULL,
    CategoryName        NVARCHAR(50) NOT NULL,
    SellStartDate       DATE NULL,
    SellEndDate         DATE NULL,
    DiscontinuedDate    DATE NULL,
    EffectiveStartDate  DATETIME NOT NULL,
    EffectiveEndDate    DATETIME NOT NULL,
    IsCurrent           BIT NOT NULL
);
GO

CREATE UNIQUE INDEX UX_DIM_PRODUCT_BK_CURRENT
    ON dbo.DIM_PRODUCT(ProductID, IsCurrent)
    WHERE IsCurrent = 1;
GO

CREATE INDEX IX_DIM_PRODUCT_BK
    ON dbo.DIM_PRODUCT(ProductID, EffectiveStartDate, EffectiveEndDate, IsCurrent);
GO

CREATE TABLE dbo.DIM_CUSTOMER (
    CustomerKey          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CustomerID           INT NOT NULL,
    CustomerType         NVARCHAR(20) NOT NULL,
    CustomerName         NVARCHAR(200) NOT NULL,
    PersonFullName       NVARCHAR(200) NOT NULL,
    StoreName            NVARCHAR(200) NOT NULL,
    AccountNumber        NVARCHAR(20) NOT NULL,
    EmailPromotion       INT NOT NULL,
    City                 NVARCHAR(50) NOT NULL,
    StateProvince        NVARCHAR(50) NOT NULL,
    CountryRegion        NVARCHAR(50) NOT NULL,
    EffectiveStartDate   DATETIME NOT NULL,
    EffectiveEndDate     DATETIME NOT NULL,
    IsCurrent            BIT NOT NULL
);
GO

CREATE UNIQUE INDEX UX_DIM_CUSTOMER_BK_CURRENT
    ON dbo.DIM_CUSTOMER(CustomerID, IsCurrent)
    WHERE IsCurrent = 1;
GO

CREATE INDEX IX_DIM_CUSTOMER_BK
    ON dbo.DIM_CUSTOMER(CustomerID, EffectiveStartDate, EffectiveEndDate, IsCurrent);
GO

/* =========================================================
   FACT TABLES
   ========================================================= */

CREATE TABLE dbo.FACT_PROMOTION_COVERAGE (
    ProductKey      INT NOT NULL,
    PromotionKey    INT NOT NULL,
    CONSTRAINT PK_FACT_PROMOTION_COVERAGE
        PRIMARY KEY (ProductKey, PromotionKey)
);
GO

CREATE TABLE dbo.FACT_PRODUCT_SALES (
    OrderDateKey        INT NOT NULL,
    ShipDateKey         INT NOT NULL,
    DueDateKey          INT NOT NULL,
    ProductKey          INT NOT NULL,
    CustomerKey         INT NOT NULL,
    TerritoryKey        INT NOT NULL,
    PromotionKey        INT NOT NULL,
    SalesOrderID        INT NOT NULL,
    SalesOrderDetailID  INT NOT NULL,
    OrderQuantity       INT NOT NULL,
    UnitPrice           DECIMAL(18,4) NOT NULL,
    GrossSalesAmount    DECIMAL(18,4) NOT NULL,
    DiscountAmount      DECIMAL(18,4) NOT NULL,
    StandardCostAmount  DECIMAL(18,4) NOT NULL,
    NetSalesAmount      DECIMAL(18,4) NOT NULL,
    MarginAmount        DECIMAL(18,4) NOT NULL,
    CONSTRAINT PK_FACT_PRODUCT_SALES
        PRIMARY KEY (SalesOrderID, SalesOrderDetailID)
);
GO

/* =========================================================
   STAGING TABLES
   ========================================================= */

CREATE TABLE dbo.stg_SalesTerritory (
    TerritoryID         INT NULL,
    Name                NVARCHAR(50) NULL,
    CountryRegionCode   NVARCHAR(3) NULL,
    [Group]             NVARCHAR(50) NULL
);
GO

CREATE TABLE dbo.stg_SpecialOffer (
    SpecialOfferID  INT NULL,
    [Description]   NVARCHAR(255) NULL,
    DiscountPct     DECIMAL(8,4) NULL,
    [Type]          NVARCHAR(50) NULL,
    Category        NVARCHAR(50) NULL,
    StartDate       DATE NULL,
    EndDate         DATE NULL,
    MinQty          INT NULL,
    MaxQty          INT NULL
);
GO

CREATE TABLE dbo.stg_Product (
    ProductID           INT NULL,
    ProductName         NVARCHAR(100) NULL,
    ProductNumber       NVARCHAR(25) NULL,
    Color               NVARCHAR(15) NULL,
    Size                NVARCHAR(10) NULL,
    Class               NVARCHAR(5) NULL,
    Style               NVARCHAR(5) NULL,
    ProductLine         NVARCHAR(5) NULL,
    DaysToManufacture   INT NULL,
    StandardCost        DECIMAL(18,4) NULL,
    ListPrice           DECIMAL(18,4) NULL,
    SubcategoryName     NVARCHAR(50) NULL,
    CategoryName        NVARCHAR(50) NULL,
    SellStartDate       DATE NULL,
    SellEndDate         DATE NULL,
    DiscontinuedDate    DATE NULL
);
GO

CREATE TABLE dbo.stg_Customer (
    CustomerID       INT NULL,
    CustomerType     NVARCHAR(20) NULL,
    CustomerName     NVARCHAR(200) NULL,
    PersonFullName   NVARCHAR(200) NULL,
    StoreName        NVARCHAR(200) NULL,
    AccountNumber    NVARCHAR(20) NULL,
    EmailPromotion   INT NULL,
    City             NVARCHAR(50) NULL,
    StateProvince    NVARCHAR(50) NULL,
    CountryRegion    NVARCHAR(50) NULL,
    TerritoryID      INT NULL
);
GO

CREATE TABLE dbo.stg_PromotionCoverage (
    ProductID        INT NULL,
    SpecialOfferID   INT NULL
);
GO

CREATE TABLE dbo.stg_Sales (
    SalesOrderID         INT NULL,
    SalesOrderDetailID   INT NULL,
    OrderDate            DATE NULL,
    ShipDate             DATE NULL,
    DueDate              DATE NULL,
    ProductID            INT NULL,
    CustomerID           INT NULL,
    TerritoryID          INT NULL,
    SpecialOfferID       INT NULL,
    OrderQty             INT NULL,
    UnitPrice            DECIMAL(18,4) NULL,
    UnitPriceDiscount    DECIMAL(18,4) NULL,
    LineTotal            DECIMAL(18,4) NULL
);
GO

/* =========================================================
   UNKNOWN MEMBERS
   ========================================================= */

IF NOT EXISTS (SELECT 1 FROM dbo.DIM_DATE WHERE DateKey = -1)
BEGIN
    INSERT INTO dbo.DIM_DATE
    (
        DateKey, FullDate, DayNum, MonthNum, MonthName, QuarterNum,
        YearNum, WeekdayName, IsWeekend, WeekNumber, FiscalYear, FiscalQuarter
    )
    VALUES
    (
        -1, '1900-01-01', 1, 1, 'Unknown', 1,
        1900, 'Unknown', 0, 1, 1900, 1
    );
END;
GO

SET IDENTITY_INSERT dbo.DIM_TERRITORY ON;
IF NOT EXISTS (SELECT 1 FROM dbo.DIM_TERRITORY WHERE TerritoryKey = -1)
BEGIN
    INSERT INTO dbo.DIM_TERRITORY
    (
        TerritoryKey, TerritoryID, TerritoryName, CountryRegionCode, RegionGroup
    )
    VALUES
    (
        -1, -1, 'Unknown', 'UNK', 'Unknown'
    );
END;
SET IDENTITY_INSERT dbo.DIM_TERRITORY OFF;
GO

SET IDENTITY_INSERT dbo.DIM_PROMOTION ON;
IF NOT EXISTS (SELECT 1 FROM dbo.DIM_PROMOTION WHERE PromotionKey = -1)
BEGIN
    INSERT INTO dbo.DIM_PROMOTION
    (
        PromotionKey, SpecialOfferID, PromotionDescription, DiscountPct,
        PromotionType, PromotionCategory, StartDate, EndDate, MinQty, MaxQty
    )
    VALUES
    (
        -1, -1, 'Unknown', 0,
        'Unknown', 'Unknown', '1900-01-01', NULL, 0, NULL
    );
END;
SET IDENTITY_INSERT dbo.DIM_PROMOTION OFF;
GO

SET IDENTITY_INSERT dbo.DIM_PRODUCT ON;
IF NOT EXISTS (SELECT 1 FROM dbo.DIM_PRODUCT WHERE ProductKey = -1)
BEGIN
    INSERT INTO dbo.DIM_PRODUCT
    (
        ProductKey, ProductID, ProductName, ProductNumber, Color, Size, Class, Style, ProductLine,
        DaysToManufacture, StandardCost, ListPrice, SubcategoryName, CategoryName,
        SellStartDate, SellEndDate, DiscontinuedDate, EffectiveStartDate, EffectiveEndDate, IsCurrent
    )
    VALUES
    (
        -1, -1, 'Unknown', 'UNK', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
        0, 0, 0, 'Unknown', 'Unknown',
        NULL, NULL, NULL, '1900-01-01', '9999-12-31', 1
    );
END;
SET IDENTITY_INSERT dbo.DIM_PRODUCT OFF;
GO

SET IDENTITY_INSERT dbo.DIM_CUSTOMER ON;
IF NOT EXISTS (SELECT 1 FROM dbo.DIM_CUSTOMER WHERE CustomerKey = -1)
BEGIN
    INSERT INTO dbo.DIM_CUSTOMER
    (
        CustomerKey, CustomerID, CustomerType, CustomerName, PersonFullName, StoreName,
        AccountNumber, EmailPromotion, City, StateProvince, CountryRegion,
        EffectiveStartDate, EffectiveEndDate, IsCurrent
    )
    VALUES
    (
        -1, -1, 'Unknown', 'Unknown Customer', 'Unknown', 'Unknown',
        'UNK', 0, 'Unknown', 'Unknown', 'Unknown',
        '1900-01-01', '9999-12-31', 1
    );
END;
SET IDENTITY_INSERT dbo.DIM_CUSTOMER OFF;
GO

/* =========================================================
   FOREIGN KEYS
   ========================================================= */

ALTER TABLE dbo.FACT_PROMOTION_COVERAGE
ADD CONSTRAINT FK_FPC_PRODUCT
    FOREIGN KEY (ProductKey) REFERENCES dbo.DIM_PRODUCT(ProductKey);
GO

ALTER TABLE dbo.FACT_PROMOTION_COVERAGE
ADD CONSTRAINT FK_FPC_PROMOTION
    FOREIGN KEY (PromotionKey) REFERENCES dbo.DIM_PROMOTION(PromotionKey);
GO

ALTER TABLE dbo.FACT_PRODUCT_SALES
ADD CONSTRAINT FK_FPS_ORDERDATE
    FOREIGN KEY (OrderDateKey) REFERENCES dbo.DIM_DATE(DateKey);
GO

ALTER TABLE dbo.FACT_PRODUCT_SALES
ADD CONSTRAINT FK_FPS_SHIPDATE
    FOREIGN KEY (ShipDateKey) REFERENCES dbo.DIM_DATE(DateKey);
GO

ALTER TABLE dbo.FACT_PRODUCT_SALES
ADD CONSTRAINT FK_FPS_DUEDATE
    FOREIGN KEY (DueDateKey) REFERENCES dbo.DIM_DATE(DateKey);
GO

ALTER TABLE dbo.FACT_PRODUCT_SALES
ADD CONSTRAINT FK_FPS_PRODUCT
    FOREIGN KEY (ProductKey) REFERENCES dbo.DIM_PRODUCT(ProductKey);
GO

ALTER TABLE dbo.FACT_PRODUCT_SALES
ADD CONSTRAINT FK_FPS_CUSTOMER
    FOREIGN KEY (CustomerKey) REFERENCES dbo.DIM_CUSTOMER(CustomerKey);
GO

ALTER TABLE dbo.FACT_PRODUCT_SALES
ADD CONSTRAINT FK_FPS_TERRITORY
    FOREIGN KEY (TerritoryKey) REFERENCES dbo.DIM_TERRITORY(TerritoryKey);
GO

ALTER TABLE dbo.FACT_PRODUCT_SALES
ADD CONSTRAINT FK_FPS_PROMOTION
    FOREIGN KEY (PromotionKey) REFERENCES dbo.DIM_PROMOTION(PromotionKey);
GO

/* =========================================================
   FACT TABLE INDEXES
   ========================================================= */

CREATE INDEX IX_FACT_PRODUCT_SALES_OrderDateKey
    ON dbo.FACT_PRODUCT_SALES(OrderDateKey);
GO

CREATE INDEX IX_FACT_PRODUCT_SALES_ProductKey
    ON dbo.FACT_PRODUCT_SALES(ProductKey);
GO

CREATE INDEX IX_FACT_PRODUCT_SALES_CustomerKey
    ON dbo.FACT_PRODUCT_SALES(CustomerKey);
GO

CREATE INDEX IX_FACT_PRODUCT_SALES_TerritoryKey
    ON dbo.FACT_PRODUCT_SALES(TerritoryKey);
GO

CREATE INDEX IX_FACT_PRODUCT_SALES_PromotionKey
    ON dbo.FACT_PRODUCT_SALES(PromotionKey);
GO