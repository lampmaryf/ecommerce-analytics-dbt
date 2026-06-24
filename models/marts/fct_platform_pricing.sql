with pricing as (
    select * from {{ ref('stg_pricing') }}
),

final as (
    select
        product_sku,
        product_category,
        cost_price,
        old_retail_price,
        discounted_price,

        -- profit margins per platform
        amazon_mrp - cost_price as amazon_profit,
        flipkart_mrp - cost_price as flipkart_profit,
        myntra_mrp - cost_price as myntra_profit,
        ajio_mrp - cost_price as ajio_profit,

        -- discount percentage
        round(
            (old_retail_price - discounted_price)
            / nullif(old_retail_price, 0) * 100, 2
        ) as discount_pct,

        -- platform prices for comparison
        amazon_mrp,
        flipkart_mrp,
        myntra_mrp,
        limeroad_mrp,
        snapdeal_mrp,
        paytm_mrp,
        ajio_mrp

    from pricing
)

select * from final