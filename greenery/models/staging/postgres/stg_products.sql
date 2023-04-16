
SELECT
  -- UUID for each unique product on platform
  product_id,
  -- Name of the product
  name,
  -- Price of the product
  price,
  -- Amount of the inventory we have for this product
  inventory
  FROM {{ source('postgres', 'products') }}