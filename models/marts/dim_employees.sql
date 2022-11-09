with staging as (
    select * from
    {{ ref('stg_employees') }}
)


, transformed  as (
    select row_number() over(order by employee_id) as employee_sk,
    employee_id,			
    last_name,				
    first_name,				
    title,				
    title_of_courtesy,				
    birth_date,			
    hire_date,			
    employee_address,				
    city,				
    region,				
    postal_code,			
    country,				
    home_phone,				
    employee_extension,				
    photo,				
    notes,				
    reports_to,		
    photo_path
    from staging
)

select *
from transformed