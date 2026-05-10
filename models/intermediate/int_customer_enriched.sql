with customers as (
    select * from {{ ref('stg_customers') }}
),

enriched as (
    select
        *,
        (case when has_online_security = 'Yes' then 1 else 0 end
        + case when has_online_backup = 'Yes' then 1 else 0 end
        + case when has_device_protection = 'Yes' then 1 else 0 end
        + case when has_tech_support = 'Yes' then 1 else 0 end
        + case when has_streaming_tv = 'Yes' then 1 else 0 end
        + case when has_streaming_movies = 'Yes' then 1 else 0 end
        )                                        as services_adopted,
        case
            when internet_type = 'No' then 'No Internet'
            when internet_type = 'DSL' then 'DSL'
            when internet_type = 'Fiber optic' then 'Fiber Optic'
        end                                      as internet_category,
        case
            when tenure_months <= 6 then true
            else false
        end                                      as is_new_customer,
        round(total_charges / nullif(tenure_months, 0), 2) as avg_monthly_spend
    from customers
)

select * from enriched
