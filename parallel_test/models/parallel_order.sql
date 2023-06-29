{{ config(materialized='table') }}
with ordersCustomers as (
    select
	    dbo.Orders.OrderID,
	    dbo.Orders.CustomerID, 
	    dbo.Orders.ShipName, 
	    dbo.customers.CompanyName, 
	    dbo.customers.ContactName, 
	    dbo.customers.City, 
	    dbo.customers.Country, 
	    dbo.customers.Phone,
	    dbo.customers.Fax 
    from dbo.Orders
    left join dbo.Customers on dbo.Customers.CustomerID = dbo.Orders.CustomerID
    where dbo.Customers.Country in ('USA', 'UK', 'Canada', 'Austria') and dbo.customers.Fax is not null
    --order by dbo.Customers.Country
)

select * from ordersCustomers