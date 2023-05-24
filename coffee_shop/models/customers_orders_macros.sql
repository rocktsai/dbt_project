{{ config(schema='dbt_customers_orders') }}
{{ config(materialized='table') }}
with first_trans as (
    select
        customers.id as id,
        customers.first_name as first_name,
        customers.last_name as last_name,
        customers.first_order_date as first_order_date,
        customers.number_of_orders as orders
    from {{ ref('customers') }}
    where first_order_date is not null
),
second_trans as (
    select
        id,
        first_name,
        last_name,
        year(first_order_date) as order_year,
        month(first_order_date) as order_month,
        day(first_order_date) as order_day,
        orders
    from first_trans
)
select * from second_trans

