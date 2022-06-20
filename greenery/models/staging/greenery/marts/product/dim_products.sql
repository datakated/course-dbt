{{
  config(
    materialized='table'
  )
}}

WITH products_dim AS (
    SELECT 
        product_id,
        name as product_name,
        price as product_default_price,
        inventory as qty_on_hand
    FROM {{ ref('products_stg') }}
    )

SELECT *
FROM products_dim