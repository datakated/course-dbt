{{
  config(
    materialized='table'
  )
}}

WITH session_activity_fact AS (
    SELECT 
    session_id
    , user_id
    , SUM(case when event_type = 'page_view' THEN 1 ELSE 0 END) as page_view_count
    , SUM(case when event_type = 'add_to_cart' THEN 1 ELSE 0 END) as add_to_cart_count
    , SUM(case when event_type = 'checkout' THEN 1 ELSE 0 END) as checkout_count
    , SUM(case when event_type = 'package_shipped' THEN 1 ELSE 0 END) as package_shipped_count
    FROM {{ ref('events_stg') }}
    GROUP BY 1,2
)


SELECT *
FROM session_activity_fact