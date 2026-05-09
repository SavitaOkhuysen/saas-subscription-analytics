# SaaS Subscription Analytics - dbt + Snowflake

A dbt project modeling subscription analytics for a B2C SaaS business, built with Snowflake as the data warehouse. Demonstrates modern data stack practices including staging/mart architecture, data quality testing, and auto-generated documentation.

## Business Questions Answered

- What is our MRR and how does it trend month over month?
- Which acquisition channels produce the lowest churn?
- Are annual vs monthly plan customers retained differently?
- Which customers are at risk based on tenure and plan type?

## Tech Stack

- dbt Core 1.11 - Model development, testing, documentation
- Snowflake - Cloud data warehouse
- SQL - Transformations across all model layers

## Data Quality Tests

13 tests across 2 staging models covering primary key uniqueness, not-null constraints, foreign key relationships, and accepted values validation. All 13 tests pass cleanly.

## Key Metrics Modeled

- MRR - Monthly recurring revenue with active vs churned breakdown
- Churn Rate - Percentage of subscriptions churned per month
- Days as Customer - Tenure for both active and churned customers
- Acquisition Performance - Revenue and churn rate by channel and plan type
