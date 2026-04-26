# SaaS Subscription Analytics — dbt + DuckDB

A dbt project modeling subscription analytics for a B2C SaaS business, built to demonstrate modern data stack skills including staging/mart architecture, data quality testing, and auto-generated documentation.

---

## Project Structure

```
models/
├── staging/
│   ├── stg_customers.sql        # Cleaned customer records
│   └── stg_subscriptions.sql   # Cleaned subscription records with churn flags
└── marts/
    ├── mrr.sql                  # Monthly Recurring Revenue by month
    ├── customer_retention.sql   # Customer lifecycle and retention metrics
    └── acquisition_performance.sql  # Churn and MRR by acquisition channel
```

---

## Business Questions Answered

- What is our MRR and how does it trend month over month?
- Which acquisition channels produce the lowest churn?
- Are annual vs monthly plan customers retained differently?
- Which customers are at risk based on tenure and plan type?

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| dbt Core 1.11 | Model development, testing, documentation |
| DuckDB | Lightweight local analytical database |
| SQL | Transformations across all model layers |

---

## Data Quality Tests

13 tests across 2 staging models covering:
- Primary key uniqueness and not-null constraints
- Foreign key relationships between customers and subscriptions
- Accepted values validation for country, plan type, acquisition channel, and status

All 13 tests pass cleanly.

---

## How to Run

```bash
# Install dependencies
pip3 install dbt-core dbt-duckdb

# Load seed data
dbt seed

# Build all models
dbt run

# Run data quality tests
dbt test

# Generate and serve documentation
dbt docs generate
dbt docs serve
```

---

## Key Metrics Modeled

- **MRR** — Monthly recurring revenue with active vs churned breakdown
- **Churn Rate** — Percentage of subscriptions churned per month
- **Days as Customer** — Tenure for both active and churned customers
- **Acquisition Performance** — Revenue and churn rate by channel and plan type
