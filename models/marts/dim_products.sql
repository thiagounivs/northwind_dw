with products as (
    select * from
    {{ ref('stg_products') }}
)
, categories as (
    select * from
    {{ ref('stg_categories') }}
)

, joining  as (
    select row_number() over(order by products.product_id) as product_sk
    , products.product_id					
    ,products.product_name					
    ,products.supplier_id					
    ,products.quantity_per_unit					
    ,products.unit_price		
    ,products.units_in_stock	
    ,products.units_on_order
    ,reorder_level  		
    ,products.is_discontinued
    ,categories.category_id		
    ,categories.category_name		
    ,categories.category_description	 
    ,categories.picture
    from products
    left join categories on categories.category_id=products.category_id
)

select *
from joining