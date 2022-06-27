{{
  config(
    materialized='table'
  )
}}

WITH user_events AS (
    SELECT 
        stg_users.user_id
        , stg_users.first_name
        , stg_users.last_name
        , stg_events.event_type
        , stg_events.order_id
        , stg_events.product_id
    FROM  {{ ref('events_stg') }} stg_events 
    JOIN {{ ref('users_stg') }} stg_users on stg_events.user_id = stg_users.user_id
    )

SELECT 
    user_id
    , first_name
    , last_name
    , {{ event_count_type() }}
    count(*) as row_count
FROM user_events

GROUP BY 1,2,3