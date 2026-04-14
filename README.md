# AdventureWorks Big Data Project

## Overview
This project implements an end-to-end analytical solution on top of AdventureWorks data, including:

- Data warehouse schema creation
- ETL workflow for dimensions and facts
- OLAP cube for multidimensional analysis
- MDX query set for business questions
- Power BI dashboard for executive reporting

The objective is to analyze sales performance, profitability, customer behavior, product contribution, geographic trends, and promotion effectiveness.

## Project Components

### 1. Data Warehouse Layer
- SQL DDL and setup scripts for dimensional structures
- Star schema centered on sales analysis
- Core dimensions and facts designed for analytical workloads

### 2. ETL Layer
- Staging-based extraction and transformation pipeline
- Dimension loading with SCD Type 2 handling where required
- Fact loading with surrogate-key resolution and measure calculations
- Unknown-member handling for referential integrity (`-1` keys)

### 3. OLAP Layer
- SSAS cube model for multidimensional reporting
- Measures for revenue, discount, net sales, cost, and margin
- Time, product, customer, territory, and promotion analysis paths

### 4. Reporting Layer
- MDX queries answering defined business questions
- Power BI dashboard connected to the cube (live connection)
- Multi-page analytical report views for management insights

## Repository Structure

- `AdventureWorks2008Cube.slnx`: SSAS/OLAP cube solution
- `AdventureWorksDW_ETL.slnx`: ETL solution and pipeline assets
- `DataBaseCreation.sql`: database and schema creation script
- `QueryAnalysis.mdx`: MDX queries for business analysis
- `PowerBIDashboard/`: dashboard assets
- `AdventureWorksSchema.png`: schema/ERD visual
- `AdventureWorks_BigData.pdf`: project report

## Core Analytical Scope

The analysis focuses on:

- Yearly, quarterly, monthly, weekday, and fiscal trends
- Product category/subcategory and top-product performance
- Customer segmentation and top-customer contribution
- Geographic performance by country/region/territory
- Promotion impact on sales, discount cost, and margin
- Coverage vs usage analysis using a factless fact design

## How to Use

### Prerequisites
- SQL Server Database Engine
- SQL Server Integration Services (SSIS)
- SQL Server Analysis Services (SSAS)
- Visual Studio with SQL Server Data Tools
- Power BI Desktop

### Suggested Execution Order
1. Run `DataBaseCreation.sql` to create warehouse structures.
2. Build and configure `AdventureWorksDW_ETL.slnx` connections.
3. Execute ETL packages to populate dimensions and facts.
4. Build and process the cube in `AdventureWorks2008Cube.slnx`.
5. Run and validate MDX in `QueryAnalysis.mdx`.
6. Open the Power BI dashboard and connect live to SSAS.

## Notes
- Dimension and fact loads are designed for reruns with integrity safeguards.
- Unknown-member rows are used to prevent load failures on unresolved lookups.
=======
# AdventureWorks Big Data Project

## Overview
This project implements an end-to-end analytical solution on top of AdventureWorks data, including:

- Data warehouse schema creation
- ETL workflow for dimensions and facts
- OLAP cube for multidimensional analysis
- MDX query set for business questions
- Power BI dashboard for executive reporting

The objective is to analyze sales performance, profitability, customer behavior, product contribution, geographic trends, and promotion effectiveness.

## Project Components

### 1. Data Warehouse Layer
- SQL DDL and setup scripts for dimensional structures
- Star schema centered on sales analysis
- Core dimensions and facts designed for analytical workloads

### 2. ETL Layer
- Staging-based extraction and transformation pipeline
- Dimension loading with SCD Type 2 handling where required
- Fact loading with surrogate-key resolution and measure calculations
- Unknown-member handling for referential integrity (`-1` keys)

### 3. OLAP Layer
- SSAS cube model for multidimensional reporting
- Measures for revenue, discount, net sales, cost, and margin
- Time, product, customer, territory, and promotion analysis paths

### 4. Reporting Layer
- MDX queries answering defined business questions
- Power BI dashboard connected to the cube (live connection)
- Multi-page analytical report views for management insights

## Repository Structure

- `AdventureWorks2008Cube.slnx`: SSAS/OLAP cube solution
- `AdventureWorksDW_ETL.slnx`: ETL solution and pipeline assets
- `DataBaseCreation.sql`: database and schema creation script
- `QueryAnalysis.mdx`: MDX queries for business analysis
- `PowerBIDashboard/`: dashboard assets
- `AdventureWorksSchema.png`: schema/ERD visual
- `AdventureWorks_BigData.pdf`: project report

## Core Analytical Scope

The analysis focuses on:

- Yearly, quarterly, monthly, weekday, and fiscal trends
- Product category/subcategory and top-product performance
- Customer segmentation and top-customer contribution
- Geographic performance by country/region/territory
- Promotion impact on sales, discount cost, and margin
- Coverage vs usage analysis using a factless fact design

## How to Use

### Prerequisites
- SQL Server Database Engine
- SQL Server Integration Services (SSIS)
- SQL Server Analysis Services (SSAS)
- Visual Studio with SQL Server Data Tools
- Power BI Desktop

### Suggested Execution Order
1. Run `DataBaseCreation.sql` to create warehouse structures.
2. Build and configure `AdventureWorksDW_ETL.slnx` connections.
3. Execute ETL packages to populate dimensions and facts.
4. Build and process the cube in `AdventureWorks2008Cube.slnx`.
5. Run and validate MDX in `QueryAnalysis.mdx`.
6. Open the Power BI dashboard and connect live to SSAS.

## Notes
- Dimension and fact loads are designed for reruns with integrity safeguards.
- Unknown-member rows are used to prevent load failures on unresolved lookups.
>>>>>>> 8f663aa3ef81b050240f8890b9cbb341a2fdb588
- Measure definitions and cube calculations should remain aligned with ETL logic.
