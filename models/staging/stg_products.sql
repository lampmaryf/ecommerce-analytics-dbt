with source as (
    select * from {{ source('ecommerce_raw', 'PRODUCT_CATALOG')}}
),

renamed as (
    select
        -- identifiers
        index as product_index,
        sku_code as product_sku,

        -- product info
        category as product_category,
        color as product_color,
        size as product_size,
        "Design No." as design_number,

        -- inventory
        cast(stock as int) as stock_quantity
    
    from source
)

select * from renamed