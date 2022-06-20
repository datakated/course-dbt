{{
  config(
    materialized='table'
  )
}}

WITH order_items_fact AS (
    SELECT 
        order_item_pk,
        order_id,
        product_id,
        quantity
    FROM {{ ref('order_items_stg') }}
    )

SELECT *
FROM order_items_fact