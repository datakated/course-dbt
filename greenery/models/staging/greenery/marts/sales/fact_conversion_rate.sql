{{
  config(
    materialized='table'
  )
}}

WITH conversion_rate AS (
    SELECT 
        COUNT(DISTINCT session_id) as session_count
        , COUNT(CASE WHEN event_type = 'checkout' THEN event_type ELSE null END) as checkout_count
        , (COUNT(CASE WHEN event_type = 'checkout' THEN event_type ELSE null END)::DOUBLE PRECISION)/(COUNT(DISTINCT session_id)::DOUBLE PRECISION) as conversion_rate

    FROM {{ ref('events_stg') }}
    )

SELECT *
FROM conversion_rate