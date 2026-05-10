# Subscription Analytics - dbt + Snowflake

A dbt project analyzing 7,043 real customer records from a subscription service, built with Snowflake as the data warehouse. Demonstrates staging/mart architecture, data quality testing, and business metric modeling using the IBM Telco Customer Churn dataset.

## Dataset

IBM Telco Customer Churn dataset (7,043 customers) with contract types, service subscriptions, tenure, charges, and churn status. Source: IBM Sample Datasets (public domain).

## Project Structure

    models/
    +-- staging/
    |   +-- stg_customers.sql         # Cleaned and standardized customer records
    |   +-- schema.yml                # Column definitions and 11 data quality tests
    +-- marts/
        +-- churn_by_contract.sql     # Churn rate, MRR, and tenure by contract type
        +-- service_adoption.sql      # Service adoption impact on churn retention
        +-- revenue_by_segment.sql    # Revenue and lifetime value by tenure segment

## Business Questions Answered

- How does churn differ across contract types (month-to-month vs annual)?
- Which services have the strongest correlation with customer retention?
- How does customer lifetime value differ across tenure and contract segments?
- Where should the business focus to reduce churn most effectively?

## Data Quality Tests

11 tests across the staging model covering:
- Primary key uniqueness and not-null (customer_id)
- Accepted values for contract type, gender, internet type, tenure segment
- Not-null on monthly charges, tenure, payment method

All tests pass cleanly against Snowflake.

## Tech Stack

- dbt Core 1.11 - Model development, testing, documentation
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

## Key Metrics Modeled

- Churn Rate by contract type and tenure segment
- Current MRR (Monthly Recurring Revenue) by segment
- Service adoption rates and their impact on churn reduction
- Average lifetime value by customer segment
