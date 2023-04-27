with products as (
    select * from {{ ref('stg_products') }}
)

select
product_id
,name
,price  
from products