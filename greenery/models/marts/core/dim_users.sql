with users as (
    select * from {{ ref('int_core_user_address')}}
)

select * from users