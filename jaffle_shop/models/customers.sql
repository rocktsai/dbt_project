{{ config(materialized='table') }}

with customers as (

    select
        id,                                        -- as customer_id,
        first_name,
        last_name
    from dbt_jaffle_shop.raw_customers

),

orders as (

    select
        id,                                        -- as order_id,
        user_id,                                   -- as customer_id,
        order_date,
        status
    from dbt_jaffle_shop.raw_orders

),

customer_orders as (
    
    select
        user_id,                                   -- customer_id,
        min(order_date) as first_order_date,       -- min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date, -- max(order_date) as most_recent_order_date,
        count(orders.id) as number_of_orders       -- count(order_id) as number_of_orders

    from orders

    group by user_id                               -- group by 1

),

final as (

    select
        customers.id,                              -- customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,          -- customer_orders.first_order_date,
        customer_orders.most_recent_order_date,    -- customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders -- coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders on customer_orders.user_id = customers.id -- left join customer_orders using (customer_id)

)

select * from final