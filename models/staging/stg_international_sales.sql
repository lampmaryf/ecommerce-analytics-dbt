with source as (
    select * from {{source('ecommerce_raw', 'INTERNATIONAL_SALES')}}
),

renamed as(
    select 
        -- identifiers
        international_sales_index,
        
        -- dates 
        try_to_date(date, 'MM-DD-YY') as sale_date,
        months as sale_month,
        
        -- customer info
        customer as customer_name,
        
        -- product info
        sku as product_sku,
        size as product_size,
        style as product_style,
        
        -- financials
        cast(gross_amount as float) as gross_amount,
        cast(rate as float) as unit_rate,
        cast(pcs as int) as quantity,
        
        from source
)

select * from renamed