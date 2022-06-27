{{
  config(
    materialized='table'
  )
}}

WITH events_fact AS (
    SELECT 
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at,
    order_id,
    product_id
    FROM {{ ref('events_stg') }}
)


SELECT *
FROM events_fact