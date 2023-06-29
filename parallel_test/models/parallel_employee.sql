{{ config(materialized='table') }}
with employee as (
    select
        EmployeeID,
        FirstName,
        LastName,
        Title,
        City,
        Country
    from dbo.Employees
)
select * from employee