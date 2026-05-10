with customers as (
    select * from {{ ref('int_customer_enriched') }}
),

service_impact as (
    select
        'Online Security'                        as service_name,
        count(case when has_online_security = 'Yes'
            then customer_id end)                as users_with_service,
        count(case when has_online_security = 'Yes' and is_churned
            then customer_id end)                as churned_with_service,
        count(case when has_online_security != 'Yes'
            then customer_id end)                as users_without_service,
        count(case when has_online_security != 'Yes' and is_churned
            then customer_id end)                as churned_without_service
    from customers

    union all

    select
        'Online Backup',
        count(case when has_online_backup = 'Yes' then customer_id end),
        count(case when has_online_backup = 'Yes' and is_churned then customer_id end),
        count(case when has_online_backup != 'Yes' then customer_id end),
        count(case when has_online_backup != 'Yes' and is_churned then customer_id end)
    from customers

    union all

    select
        'Device Protection',
        count(case when has_device_protection = 'Yes' then customer_id end),
        count(case when has_device_protection = 'Yes' and is_churned then customer_id end),
        count(case when has_device_protection != 'Yes' then customer_id end),
        count(case when has_device_protection != 'Yes' and is_churned then customer_id end)
    from customers

    union all

    select
        'Tech Support',
        count(case when has_tech_support = 'Yes' then customer_id end),
        count(case when has_tech_support = 'Yes' and is_churned then customer_id end),
        count(case when has_tech_support != 'Yes' then customer_id end),
        count(case when has_tech_support != 'Yes' and is_churned then customer_id end)
    from customers

    union all

    select
        'Streaming TV',
        count(case when has_streaming_tv = 'Yes' then customer_id end),
        count(case when has_streaming_tv = 'Yes' and is_churned then customer_id end),
        count(case when has_streaming_tv != 'Yes' then customer_id end),
        count(case when has_streaming_tv != 'Yes' and is_churned then customer_id end)
    from customers

    union all

    select
        'Streaming Movies',
        count(case when has_streaming_movies = 'Yes' then customer_id end),
        count(case when has_streaming_movies = 'Yes' and is_churned then customer_id end),
        count(case when has_streaming_movies != 'Yes' then customer_id end),
        count(case when has_streaming_movies != 'Yes' and is_churned then customer_id end)
    from customers
),

final as (
    select
        service_name,
        users_with_service,
        round(churned_with_service * 100.0
            / nullif(users_with_service, 0), 1)  as churn_rate_with_service,
        users_without_service,
        round(churned_without_service * 100.0
            / nullif(users_without_service, 0), 1) as churn_rate_without_service,
        round(churned_without_service * 100.0
            / nullif(users_without_service, 0), 1)
        - round(churned_with_service * 100.0
            / nullif(users_with_service, 0), 1)  as churn_reduction_pct
    from service_impact
)

select * from final
order by churn_reduction_pct desc
