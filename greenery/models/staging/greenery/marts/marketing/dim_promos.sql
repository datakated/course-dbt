{{
  config(
    materialized='table'
  )
}}

WITH promos_dim AS (
    SELECT 
        promo_id,
        discount,
        status as promo_status
    FROM {{ ref('promos_stg') }}
    )

SELECT *
FROM promos_dim