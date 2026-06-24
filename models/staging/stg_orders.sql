with source as (
    select * from {{ source('ecommerce_raw', 'AMAZON_SALE_REPORT')}}
),
renamed as (
    select
        -- identifiers
        order_id,
        order_index,

        -- dates
        try_to_date(date, 'MM-DD-YY') as order_date,

        -- product info
        asin as product_asin,
        sku as product_sku,
        category as product_category,
        size as product_size,

        -- order details 
        status as order_status,
        fulfillment as fulfillment_type,
        fulfilled_by,
        sales_channel,
        ship_service_level,
        courier_status,

        -- financials
        cast(amount as float) as order_amount,
        currency as currency_code,
        cast(quantity as int) as quantity,

        -- shipping address
        ship_city,
        ship_state,
        ship_country,
        ship_postal_code,

        -- flags
        cast(b2b as boolean) as is_b2b,
        promotion_ids as promo_ids,

    from source
)

select * from renamed