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
        cast(stock as int) as stock_quantity,

        -- deduplication
        row_number() over (
            partition by sku_code
            order by index
        ) as row_num
    
    from source
    where sku_code is not null
),

deduped as (
    select * from renamed
    where row_num = 1
)

select
    product_index,
    product_sku,
    product_category,
    product_color,
    product_size,
    design_number,
    stock_quantity
from deduped