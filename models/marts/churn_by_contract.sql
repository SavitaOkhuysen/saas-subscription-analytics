with customers as (
    select * from {{ ref('int_customer_enriched') }}
),

churn_metrics as (
    select
        contract_type,
        count(customer_id)                       as total_customers,
        count(case when is_churned
            then customer_id end)                as churned_customers,
        count(case when not is_churned
            then customer_id end)                as active_customers,
        {{ churn_rate('is_churned', 'customer_id') }} as churn_rate_pct,
        round(avg(monthly_charges), 2)           as avg_monthly_charges,
        round(avg(tenure_months), 1)             as avg_tenure_months,
        round(avg(services_adopted), 1)          as avg_services_adopted,
        round(sum(case when not is_churned
            then monthly_charges else 0 end), 2) as current_mrr
    from customers
    group by 1
)

select * from churn_metrics
order by churn_rate_pct desc
