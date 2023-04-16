SELECT 
  -- UUID for each unique address on platform
  address_id,
  -- The first few lines of the address
  address,
  -- The zipcode of the address
  zipcode,
  -- state this delivery address is based in
  state,
  -- country this delivery address is based in
  country
FROM {{ source('postgres', 'addresses') }}