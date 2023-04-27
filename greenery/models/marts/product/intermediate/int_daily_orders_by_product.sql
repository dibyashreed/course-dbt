with orders as (
    select * from {{ ref('stg_orders')}}
),

order_items as (
    select * from {{ ref('stg_order_items')}}
),

agg_product_orders as (
    select
        oi.product_id
        ,o.created_at::date as order_date
        ,count(distinct o.order_id) as orders
        ,sum(oi.quantity) as units

    from orders o
    join order_items oi
        on o.order_id = oi.order_id 

    group by 1,2
)

select 
        CONCAT('order_date', 'product_id') as unique_key,
        *
from agg_product_orders 