{% macro convert_date(column_name) %}

CASE
    WHEN {{ column_name }} IS NULL
      OR TRIM({{ column_name }}) = ''
      OR UPPER(TRIM({{ column_name }})) = 'NULL'
    THEN NULL
    ELSE TRY_TO_DATE(
        CONCAT(
            SUBSTRING(TRIM({{ column_name }}),1,6),
            '19',
            SUBSTRING(TRIM({{ column_name }}),7,2)
        )
    )
END

{% endmacro %}


{% macro region_col_handling(region_col) %}

    CASE
        WHEN {{region_col}} IS NULL OR TRIM({{region_col}}) = 'NULL' OR TRIM({{region_col}}) =''
            THEN 'UN_KNOWN'
        ELSE TRIM({{region_col}})
    END


{% endmacro %}