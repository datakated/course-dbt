{{
  config(
    materialized='table'
  )
}}

WITH address_dim AS (
    SELECT 
        address_id,
        address as street_address,
        zipcode as address_zipcode,
        state as address_state,
        country as address_country
    FROM {{ ref('addresses_stg') }}
    )

SELECT *
FROM address_dim