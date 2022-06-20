{{
  config(
    materialized='table'
  )
}}

WITH users_dim AS (
    SELECT 
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at as user_created_at_utc,
        updated_at as user_updated_at_utc,
        address_id
    FROM {{ ref('users_stg') }}
    )

SELECT *
FROM users_dim