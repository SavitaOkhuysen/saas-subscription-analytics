with customers as (
    select * from {{ ref('stg_customers') }}
),

subscriptions as (
    select * from {{ ref('stg_subscriptions') }}
),

joined as (
    select
        c.acquisition_channel,
        c.plan_type,
        count(distinct c.customer_id)            as total_customers,
        count(case when s.status = 'active' 
            then c.customer_id end)              as active_customers,
        count(case when s.is_churned 
            then c.customer_id end)              as churned_customers,
        round(
            count(case when s.is_churned 
                then c.customer_id end) * 100.0
            / nullif(count(distinct c.customer_id), 0)
        , 2)                                     as churn_rate_pct,
        sum(case when s.status = 'active' 
            then s.monthly_amount else 0 end)    as total_mrr
    from customers c
    left join subscriptions s
        on c.customer_id = s.customer_id
    group by 1, 2
)

select * from joined
order by total_customers desc
