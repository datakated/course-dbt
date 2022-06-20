{{
  config(
    materialized='table'
  )
}}

WITH orders_fact AS (
    SELECT 
        order_id,
        promo_id, 
        user_id,
        address_id,
        created_at as order_created_at_utc,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id,
        shipping_service,
        estimated_delivery_at as order_estimated_delivery_at_utc,
        delivered_at as order_delivered_at_utc,
        status as order_status
    FROM {{ ref('orders_stg') }}
    )

SELECT *
FROM orders_fact