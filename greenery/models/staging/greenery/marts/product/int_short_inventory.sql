{{
  config(
    materialized='table'
  )
}}

/* This dataset shows all products that have less than two months of average sales left on hand, so they need to be reordered soon */



WITH product_inventory AS (
    SELECT 
        product_id,
        name as product_name,
        inventory as qty_on_hand
    FROM {{ ref('products_stg') }}
    ),

monthly_product_sales AS (
  SELECT EXTRACT(YEAR from os.created_at) AS order_year,
         EXTRACT(MONTH from os.created_at) AS order_month,
         o_items.product_id,
         SUM(o_items.quantity) as month_qty
    FROM {{ ref('order_items_stg') }} o_items
    JOIN {{ ref('orders_stg') }} os on o_items.order_id = os.order_id
    GROUP BY 1,2,3
),

average_product_sales AS (
  SELECT product_id,
  AVG(month_qty) as average_monthly_qty
  FROM monthly_product_sales
  GROUP BY 1)




SELECT 
product_inventory.product_id,
product_inventory.product_name,
product_inventory.qty_on_hand,
average_product_sales.average_monthly_qty
FROM average_product_sales
LEFT JOIN product_inventory on product_inventory.product_id = average_product_sales.product_id

WHERE product_inventory.qty_on_hand < average_product_sales.average_monthly_qty*2



