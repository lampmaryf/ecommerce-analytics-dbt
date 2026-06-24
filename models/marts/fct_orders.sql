with orders as (
    select * from {{ ref('stg_orders') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

final as (
    select
        -- identifiers
        orders.order_id,
        orders.order_index,

        -- dates
        orders.order_date,

        -- product info
        orders.product_sku,
        orders.product_category,
        products.product_color,
        products.stock_quantity,

        -- order details
        orders.order_status,
        orders.fulfillment_type,
        orders.fulfilled_by,
        orders.sales_channel,
        orders.ship_service_level,
        orders.ship_city,
        orders.ship_state,
        orders.ship_country,

        -- financials
        orders.order_amount,
        orders.quantity,
        orders.is_b2b

    from orders
    left join products  
        on orders.product_sku = products.product_sku
)

select * from final