with source as (
    select * from {{ ref('customer_churn_data') }}
),

cleaned as (
    select
        customerid                               as customer_id,
        gender,
        seniorcitizen                            as is_senior,
        partner                                  as has_partner,
        dependents                               as has_dependents,
        tenure                                   as tenure_months,
        phoneservice                             as has_phone,
        multiplelines                            as has_multiple_lines,
        internetservice                          as internet_type,
        onlinesecurity                           as has_online_security,
        onlinebackup                             as has_online_backup,
        deviceprotection                         as has_device_protection,
        techsupport                              as has_tech_support,
        streamingtv                              as has_streaming_tv,
        streamingmovies                          as has_streaming_movies,
        contract                                 as contract_type,
        paperlessbilling                         as has_paperless_billing,
        paymentmethod                            as payment_method,
        monthlycharges                           as monthly_charges,
        case
            when totalcharges = ' ' then 0
            else totalcharges::float
        end                                      as total_charges,
        case
            when churn = 'Yes' then true
            else false
        end                                      as is_churned,
        case
            when tenure <= 12 then 'New (0-12 months)'
            when tenure <= 24 then 'Mid (13-24 months)'
            else 'Long-term (25+ months)'
        end                                      as tenure_segment
    from source
)

select * from cleaned
