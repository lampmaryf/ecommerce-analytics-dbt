with international_sales as (
    select * from {{ ref('stg_international_sales')}}
),

products as (
    select * from {{ref('stg_products')}}
),

final as (
    select
        -- identifiers
        international_sales.international_sales_index,

        -- dates
        international_sales.sale_date,
        international_sales.sale_month,

        -- customer info
        international_sales.customer_name,

        -- product info
        international_sales.product_sku,
        international_sales.product_size,
        international_sales.product_style,
        products.product_category,
        products.product_color,

        -- financials
        international_sales.gross_amount,
        international_sales.unit_rate,
        international_sales.quantity,
    
    from international_sales
    left join products
        on international_sales.product_sku = products.product_sku
)

select * from final