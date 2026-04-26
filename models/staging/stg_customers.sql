with source as (
    select * from {{ ref('customers') }}
),

renamed as (
    select
        customer_id,
        created_at::date                         as created_date,
        country,
        acquisition_channel,
        plan_type
    from source
)

select * from renamed
