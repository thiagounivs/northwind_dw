with source_data as (
    select 
    customer_id	,			
    company_name	,			
    contact_name	,			
    contact_title	,			
    address	as address_customers,			
    city	,			
    region	,			
    postal_code	,			
    country	,			
    phone,			
    fax
    from  {{ source('northwind_erp', 'public_customers') }}
)


select * from source_data