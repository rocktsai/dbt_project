{{ config(materialized='table') }}
with customers as (
    select
        CustomerID,
        CompanyName,
        City,
        Country
    from dbo.Customers
    where Country = 'USA'
)
select * from customers