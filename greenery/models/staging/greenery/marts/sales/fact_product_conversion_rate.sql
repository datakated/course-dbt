{{
  config(
    materialized='table'
  )
}}

WITH product_conversion_rate AS (
    SELECT 
        product_id
        , SUM( CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) as page_view_count
        , SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS checkout_count

    FROM {{ ref('events_stg') }}
    WHERE product_id is not null
    GROUP BY 1
    ),

    product_names AS (
    SELECT 
        product_id
        , name as product_name
    FROM {{ ref('products_stg') }}
    )


SELECT 
  product_names.product_name
, product_conversion_rate.checkout_count::DOUBLE PRECISION/product_conversion_rate.page_view_count::DOUBLE PRECISION
FROM product_conversion_rate
JOIN product_names on product_conversion_rate.product_id = product_names.product_id