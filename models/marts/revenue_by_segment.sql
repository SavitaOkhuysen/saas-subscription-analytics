with customers as (
    select * from {{ ref('stg_customers') }}
),

segments as (
    select
        tenure_segment,
        contract_type,
        count(customer_id)                       as total_customers,
        count(case when is_churned
            then customer_id end)                as churned_customers,
        round(
            count(case when is_churned
                then customer_id end) * 100.0
            / nullif(count(customer_id), 0)
        , 1)                                     as churn_rate_pct,
        round(avg(monthly_charges), 2)           as avg_monthly_charges,
        round(avg(total_charges), 2)             as avg_lifetime_value,
        round(sum(case when not is_churned
            then monthly_charges else 0 end), 2) as segment_mrr
    from customers
    group by 1, 2
)

select * from segments
order by tenure_segment, churn_rate_pct desc
