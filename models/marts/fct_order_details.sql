with customers as (
    select 
    customer_sk,
    customer_id 
    from
    {{ ref('dim_customers') }}
)
, employees as (
    select 
    employee_sk,
    employee_id 
    from
    {{ ref('dim_employees') }}

), products as (
    select  
    product_sk,
    product_id
    from 
     {{ ref('dim_products') }}

), order_with_sk as (
    select 
    orders.order_id,
    employees.employee_sk as employee_fk,
    customers.customer_sk   as customer_fk,
    orders.order_date,
    orders.ship_region,
    orders.shipped_date,
    orders.ship_country,
    orders.ship_name,
    orders.ship_city,
   -- orders.required_data
    from {{ref('stg_orders')}} orders
    left join employees on orders.employee_id = employees.employee_id
    left join customers on orders.customer_id = customers.customer_id

), order_details_with_sk as (
    select 
        order_details.order_id,
        products.product_sk as product_fk,
        order_details.unit_price,				
        order_details.quantity,		
        order_details.discount
    from {{ref('stg_order_details')}} order_details
    left join products on products.product_id = order_details.product_id
),

final as (
    select 
    order_details.order_id,
    orders.employee_fk,
    orders.customer_fk,
    order_details.product_fk,
    orders.order_date,
    orders.ship_region,
    orders.shipped_date,
    orders.ship_country,
    orders.ship_name,
    orders.ship_city,
    --orders.required_data
    from order_with_sk as orders
    left join order_details_with_sk order_details on order_details.order_id=orders.order_id

)

select * from final