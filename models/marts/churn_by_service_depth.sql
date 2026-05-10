with customers as (
    select * from {{ ref('int_customer_enriched') }}
),

service_depth as (
    select
        services_adopted,
        count(customer_id)                       as total_customers,
        count(case when is_churned
            then customer_id end)                as churned_customers,
        {{ churn_rate('is_churned', 'customer_id') }} as churn_rate_pct,
        round(avg(monthly_charges), 2)           as avg_monthly_charges,
        round(avg(tenure_months), 1)             as avg_tenure_months
    from customers
    group by 1
)

select * from service_depth
order by services_adopted
