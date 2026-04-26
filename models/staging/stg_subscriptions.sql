with source as (
    select * from {{ ref('subscriptions') }}
),

renamed as (
    select
        subscription_id,
        customer_id,
        started_at::date                         as start_date,
        ended_at::date                           as end_date,
        plan_type,
        monthly_amount,
        status,
        case
            when status = 'churned' then true
            else false
        end                                      as is_churned
    from source
)

select * from renamed
