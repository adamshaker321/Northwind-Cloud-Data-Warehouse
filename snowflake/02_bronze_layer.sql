-- CREATE BRONZE TABLES

USE SCHEMA BRONZE;

CREATE TABLE BRONZE.Customers(

cust_id string,
company_name string,
contact_name string,
contact_title string,
address string,
city string,
region string,
postal_code string,
country string
);

CREATE TABLE BRONZE.Products(

prod_id string,
prod_name string,
supplier_id string,
category_id string,
quantity_per_unit string,
unit_price string,
units_in_stock string,
units_on_order string,
reorder_level string,
discounted string
);

CREATE TABLE BRONZE.Employees(

emp_id string,
first_name string,
last_name string,
title string,
title_of_courtesy string,
birth_date string,
hire_date string,
address string,
city string,
region string,
postal_code string,
country string
);

CREATE TABLE BRONZE.Shippers(

shipper_id string,
company_name string
);

CREATE TABLE BRONZE.Suppliers(

supplier_id string,
company_name string,
contact_name string,
contact_title string,
address string,
city string,
region string,
postal_code string,
country string
);

CREATE TABLE BRONZE.Categories(

category_id string,
category_name string
);

CREATE TABLE BRONZE.Orders(

order_id string,
customer_id string,
employee_id string,
order_date string,
required_date string,
shipped_date string,
ship_via string,
freight string,
ship_name string,
ship_address string,
ship_city string,
ship_region string,
ship_postal_code string,
ship_country string
);

CREATE TABLE BRONZE.Order_details(

order_id string,
product_id string,
unit_price string,
quantity string,
discount string
);



-- storage integration
CREATE STORAGE INTEGRATION NORTHWIND_S3_INTEG
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN='arn:aws:iam::551569010870:role/SnowflakeNorthwindRole'
STORAGE_ALLOWED_LOCATIONS=('s3://northwind-sales-files/');

DESC INTEGRATION NORTHWIND_S3_INTEG;



-- file format
CREATE OR REPLACE FILE FORMAT CSV_FORMAT
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
ENCODING = 'ISO8859-1';




-- external stage
CREATE OR REPLACE STAGE EXTERNAL_STAGE
URL = "s3://northwind-sales-files/"
STORAGE_INTEGRATION = NORTHWIND_S3_INTEG
FILE_FORMAT=CSV_FORMAT;



-- copy into
COPY INTO BRONZE.CUSTOMERS
FROM @EXTERNAL_STAGE/customers.csv
ON_ERROR='CONTINUE';

COPY INTO BRONZE.PRODUCTS
FROM @EXTERNAL_STAGE/products.csv
ON_ERROR='CONTINUE';

COPY INTO BRONZE.ORDERS
FROM @EXTERNAL_STAGE/orders.csv
ON_ERROR='CONTINUE';

COPY INTO BRONZE.SHIPPERS
FROM @EXTERNAL_STAGE/shippers.csv
ON_ERROR='CONTINUE';

COPY INTO BRONZE.SUPPLIERS
FROM @EXTERNAL_STAGE/suppliers.csv
ON_ERROR='CONTINUE';

COPY INTO BRONZE.ORDER_DETAILS
FROM @EXTERNAL_STAGE/order_details.csv
ON_ERROR='CONTINUE';

COPY INTO BRONZE.CATEGORIES
FROM @EXTERNAL_STAGE/categories.csv
ON_ERROR='CONTINUE';

COPY INTO BRONZE.EMPLOYEES
FROM @EXTERNAL_STAGE/employees.csv
ON_ERROR='CONTINUE';


LIST @EXTERNAL_STAGE
DESC INTEGRATION NORTHWIND_S3_INTEG;


