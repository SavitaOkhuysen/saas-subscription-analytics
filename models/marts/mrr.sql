with subscriptions as (
    select * from {{ ref('stg_subscriptions') }}
),

mrr as (
    select
        date_trunc('month', start_date)          as month,
        count(subscription_id)                   as total_subscriptions,
        count(case when status = 'active' 
            then subscription_id end)            as active_subscriptions,
        count(case when is_churned 
            then subscription_id end)            as churned_subscriptions,
        sum(case when status = 'active' 
            then monthly_amount else 0 end)      as mrr,
        round(
            count(case when is_churned 
                then subscription_id end) * 100.0
            / nullif(count(subscription_id), 0)
        , 2)                                     as churn_rate_pct
    from subscriptions
    group by 1
)

select * from mrr
order by month
