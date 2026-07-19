SELECT 
    O.ORDER_ID,
    dc.CUSTOMER_KEY,
    dp.PRODUCT_KEY,
    de.EMPLOYEE_KEY,
    ds.SHIPPER_KEY,
    od.UNIT_PRICE,
    od.QUANTITY,
    (od.QUANTITY*od.UNIT_PRICE) AS SALES_AMOUNT,
    od.DISCOUNT,
    o.FREIGHT,
    odd.DATE_KEY AS ORDER_DATE_KEY,
    rdd.DATE_KEY AS REQUIRED_DATE_KEY,
    sdd.DATE_KEY AS SHIPPED_DATE_KEY,


FROM {{ ref('orders') }} o

JOIN {{ ref('order_details') }} od
    ON o.ORDER_ID = od.ORDER_ID

JOIN {{ ref('dim_customers') }} dc
    ON o.CUSTOMER_ID = dc.CUST_ID

JOIN {{ ref('dim_products') }} dp
    ON od.PRODUCT_ID = dp.PROD_ID

JOIN {{ ref('dim_employees') }} de
    ON o.EMPLOYEE_ID = de.EMP_ID

JOIN {{ ref('dim_shippers') }} ds
    ON o.SHIPPER_ID = ds.SHIPPER_ID

LEFT JOIN {{ ref('dim_date') }} odd
    ON o.ORDER_DATE = odd.FULL_DATE

LEFT JOIN {{ ref('dim_date') }} rdd
    ON o.REQUIRED_DATE = rdd.FULL_DATE

LEFT JOIN {{ ref('dim_date') }} sdd
    ON o.SHIPPED_DATE = sdd.FULL_DATE