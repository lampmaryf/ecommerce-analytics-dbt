with products as (
    select * from {{ ref('stg_products') }}
),

pricing as (
    select * from {{ ref('stg_pricing') }}
),

final as (
    select
        -- identifiers
        products.product_sku,
        products.product_index,

        -- product info
        products.product_category,
        products.product_color,
        products.product_size,
        products.design_number,

        -- inventory
        products.stock_quantity,

        -- pricing
        pricing.catalog_name,
        pricing.cost_price,
        pricing.old_retail_price,
        pricing.discounted_price,

        -- platform pricing
        pricing.ajio_mrp,
        pricing.amazon_mrp,
        pricing.amazon_fba_mrp,
        pricing.flipkart_mrp,
        pricing.myntra_mrp,
        pricing.limeroad_mrp,
        pricing.snapdeal_mrp,
        pricing.paytm_mrp,
        
    from products
    left join pricing 
        on products.product_sku = pricing.product_sku
)

select * from final