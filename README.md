# Northwind Cloud Data Warehouse

## Overview

An end-to-end cloud data warehouse project built using **AWS S3, Snowflake, and dbt** following the **Medallion Architecture (Bronze, Silver, Gold)**. Raw CSV data is loaded into Snowflake, transformed using dbt, and modeled into a Star Schema for analytics.

---

## Technologies

- AWS S3
- Snowflake
- dbt
- SQL
- Star Schema
- Data Modeling

---

## Architecture

```
CSV Files
    ↓
AWS S3
    ↓
Snowflake External Stage
    ↓
Bronze Layer
    ↓
Silver Layer (dbt)
    ↓
Gold Layer (Star Schema)
```

---

## Data Model

### Dimensions
- Dim Customers
- Dim Products
- Dim Employees
- Dim Shippers
- Dim Date

### Fact
- Fact Sales

---

## Project Structure

```
snowflake/
dbt/
architecture/
screenshots/
README.md
```

---

## Skills Demonstrated

- Cloud Data Warehousing
- ELT Pipeline
- Snowflake
- dbt
- Data Transformation
- Star Schema
- Data Modeling

---

## How to Run

```bash
dbt run
dbt test
dbt docs generate
dbt docs serve
```
