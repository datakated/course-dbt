{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id || '-' || product_id as order_item_pk,
    order_id,
    product_id,
    quantity
FROM {{ source('greenery_src', 'order_items') }}