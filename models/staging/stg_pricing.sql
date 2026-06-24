with source as (
    select * from {{ source('ecommerce_raw', 'MAY_2022_PRICING')}}
),

renamed as (
    select
        -- identifiers
        pricing_index,
        sku as product_sku,
        style_id as product_style_id,
        catalog as catalog_name,
        category as product_category,

        -- pricing by platform
        cast(ajio_mrp as float) as ajio_mrp,
        cast(amazon_mrp as float) as amazon_mrp,
        cast(amazon_fba_mrp as float) as amazon_fba_mrp,
        cast(flipkart_mrp as float) as flipkart_mrp,
        cast(myntra_mrp as float) as myntra_mrp,
        cast(limeroad_mrp as float) as limeroad_mrp,
        cast(snapdeal_mrp as float) as snapdeal_mrp,
        cast(paytm_mrp as float) as paytm_mrp,

        -- other pricing
        cast(mrp_old as float) as old_retail_price,
        cast(final_mrp_old as float) as discounted_price,
        cast(tp as float) as cost_price,
        cast(weight as float) as weight_kg

    from source
)

select * from renamed