# Subscription Analytics - dbt + Snowflake

A dbt project analyzing 7,043 real customer records from a subscription service, built with Snowflake as the data warehouse. Demonstrates staging, intermediate, and mart architecture, reusable macros, data quality testing across all layers, and business metric modeling using the IBM Telco Customer Churn dataset.

## Dataset

IBM Telco Customer Churn dataset (7,043 customers) with contract types, service subscriptions, tenure, charges, and churn status. Source: [IBM Telco Customer Churn Dataset](https://github.com/IBM/telco-customer-churn-on-icp4d/blob/master/data/Telco-Customer-Churn.csv)

## Project Structure

    models/
    +-- staging/
    |   +-- stg_customers.sql              # Cleaned and standardized customer records
    |   +-- schema.yml                     # 10 data quality tests
    +-- intermediate/
    |   +-- int_customer_enriched.sql      # Enriched with service count, tenure flags, avg spend
    |   +-- schema.yml                     # Uniqueness and null tests
    +-- marts/
        +-- churn_by_contract.sql          # Churn rate and MRR by contract type
        +-- service_adoption.sql           # Service adoption impact on churn retention
        +-- revenue_by_segment.sql         # Revenue and lifetime value by tenure segment
        +-- churn_by_service_depth.sql     # Churn rate by number of services adopted
        +-- schema.yml                     # Mart-level business logic tests
    macros/
    +-- churn_rate.sql                     # Reusable macro for churn rate calculation

## Architecture

Staging -> Intermediate -> Marts

- Staging cleans raw data and enforces data quality
- Intermediate enriches with calculated fields used by multiple marts (service count, customer flags, derived metrics)
- Marts answer specific business questions using the enriched data
- A reusable churn_rate macro keeps calculation logic consistent across all mart models

## Business Questions Answered

- How does churn differ across contract types (month-to-month vs annual)?
- Which services have the strongest correlation with customer retention?
- Does adopting more services reduce churn? (service depth analysis)
- How does customer lifetime value differ across tenure and contract segments?

## Data Quality

Tests across all three layers:
- Staging: 10 tests (primary key, accepted values, not-null constraints)
- Intermediate: 2 tests (uniqueness, not-null on enriched data)
- Marts: 8 tests (business logic validation on output models)

Total: 20 data quality tests, all passing.

## Reusable Macro

The churn_rate macro standardizes churn calculation across all marts:

    {{ churn_rate('is_churned', 'customer_id') }}

This prevents inconsistent churn definitions across models. Define the logic once, use it everywhere.

## Tech Stack

- dbt Core 1.11 - Model development, testing, documentation, macros
- Snowflake - Cloud data warehouse
- SQL - Transformations across all model layers
- Real-world dataset (7,043 customer records)

## How to Run

    pip3 install dbt-core dbt-snowflake
    # Configure Snowflake connection in ~/.dbt/profiles.yml
    dbt seed
    dbt run
    dbt test
    dbt docs generate
    dbt docs serve

## Companion Project

For the analytical layer (visualizations, findings, and business recommendations) built on this same dataset, see: github.com/SavitaOkhuysen/saas-product-analytics
