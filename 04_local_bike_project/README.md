# Local Bike — Analytics Engineering Project

![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)
![Metabase](https://img.shields.io/badge/Metabase-509EE3?style=flat&logo=metabase&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?style=flat&logo=githubactions&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)

---

## 🎯 Objective

End-to-end analytics engineering pipeline to optimize revenue for a local bike store chain — from raw Snowflake data to production-ready Metabase dashboards.

---

## 🏗️ Architecture

```
Raw Data (Snowflake)
       ↓
   Staging Layer       → 9 views   (standardization, renaming, casting)
       ↓
 Intermediate Layer    → 2 views   (enrichment, business logic, KPI computation)
       ↓
   Marts Layer         → 5 tables  (Star Schema, ready for BI)
       ↓
  Metabase Dashboard   → Revenue analysis
```

**16 dbt models | 96 tests | Star Schema | CI/CD on every Pull Request**

---

## ⭐ Star Schema

```
              dim_customers
                    |
dim_stores ── fact_sales ── dim_products
                    |
              dim_dates
```

---

## 📁 Project Structure

```
04_local_bike_project/
├── dbt_analytics/
│   ├── models/
│   │   ├── staging/         
│   │   ├── intermediate/     
│   │   └── marts/           
│   ├── tests/               
│   ├── macros/              
│   ├── packages.yml        
│   └── dbt_project.yml
├── metabase/
│   └── docker-compose.yml    # Metabase local setup
└── docs/
    └── *.png                 # Dashboard screenshots
```

---

## 🚀 Getting Started

### Prerequisites

- Python 3.12
- Docker Compose
- A Snowflake account with `DBT_ROLE` and `METABASE_ROLE` configured

### 1. Clone the repository

```bash
git clone https://github.com/MoussaInc/databird-analytics-engineer.git
cd databird-analytics-engineer/04_local_bike_project
```

### 2. Set up Python environment

```bash
python -m venv .venv
source .venv/bin/activate
pip install dbt-snowflake
```

### 3. Configure dbt profile

Create `~/.dbt/profiles.yml`:

```yaml
dbt_snow:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <SNOWFLAKE_ACCOUNT>
      user: <SNOWFLAKE_USER>
      password: <SNOWFLAKE_PASSWORD>
      role: DBT_ROLE
      database: DBT_DB
      warehouse: <SNOWFLAKE_WAREHOUSE>
      schema: PUBLIC
      threads: 4
```

### 4. Run dbt

```bash
cd dbt_analytics/

# Install packages
dbt deps

# Run all models
dbt run

# Run all tests
dbt test

# Or run everything at once
dbt build
```

### 5. Launch Metabase

```bash
cd metabase/

# Start Metabase container
docker-compose up -d

# Access the UI
open http://localhost:3000
```

**Metabase Snowflake connection settings:**

| Field | Value |
|---|---|
| Account | `<SNOWFLAKE_ACCOUNT>` |
| Username | `METABASE_USER` |
| Role | `METABASE_ROLE` |
| Database | `DBT_DB` |
| Schema | `PUBLIC_MARTS` |

---

## 🧪 Data Quality

96 tests covering:

- `not_null` and `unique` on all primary keys
- `relationships` between staging, intermediate and marts models
- `accepted_values` on `order_status`
- `expression_is_true` on business metrics (discount range, revenue consistency, quantity)
- Singular tests on data integrity (positive revenue, delivery delay coherence)

---

## 📊 Metabase Dashboard — Revenue Optimization

**Global KPIs**
- Total Revenue (Net)
- Number of Orders
- Average Basket
- On-time Delivery Rate

**Revenue Analysis And Product/Store Performance**
- Monthly revenue trend
- Revenue by store, category, brand
- Monthly evolution by store (multi-series)
- Top 10 products by revenue
- Revenue by category & brand
- Average discount by category
- On-time delivery rate by store
- Orders by store and status
- Top 20 customers by revenue
- Average basket per customer
- Revenue by city

**Global Filters:** Date range | Store | Category | Order status

---

## ⚙️ CI/CD — GitHub Actions

Triggered on every Pull Request targeting `main`:

- `dbt deps` → install packages
- `dbt debug` → validate connection
- `dbt build` → run models + tests (Slim CI if manifest available)
- Auto-cleanup of CI schema after each PR

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| **Snowflake** | Cloud data warehouse |
| **dbt** | Data transformation, testing & documentation |
| **dbt_utils** | Utility macros (surrogate key, date spine, expression tests) |
| **GitHub Actions** | CI/CD pipeline |
| **Metabase** | BI dashboards & data visualization |
| **Docker** | Metabase containerization |