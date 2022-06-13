{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id,
    product_id,
    quantity
FROM {{ source('greenery_src', 'order_items') }}