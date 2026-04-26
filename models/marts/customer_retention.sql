with customers as (
    select * from {{ ref('stg_customers') }}
),

subscriptions as (
    select * from {{ ref('stg_subscriptions') }}
),

joined as (
    select
        c.customer_id,
        c.created_date,
        c.country,
        c.acquisition_channel,
        c.plan_type,
        s.status,
        s.start_date,
        s.end_date,
        s.monthly_amount,
        s.is_churned,
        case
            when s.is_churned then
                s.end_date - s.start_date
            else
                current_date - s.start_date
        end                                      as days_as_customer
    from customers c
    left join subscriptions s
        on c.customer_id = s.customer_id
)

select * from joined
