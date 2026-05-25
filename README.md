# Data Analytics Engineering Portfolio

> End-to-end Analytics Engineering portfolio: advanced SQL, data ingestion, dbt transformation, CI/CD, orchestration and BI dashboarding on GCP/BigQuery & Snowflake.

---

## 🗂️ Project Structure

```
databird-analytics-engineer/
├── 01_cloud_sql_advanced/       # Advanced SQL & BigQuery
├── 02_Fivetran_Airbyte/         # Data ingestion (ELT)
├── 03_dbt/                      # dbt Core transformation + CI/CD (BigQuery)
├── 04_local_bike_project/       # Full Analytics Engineering project:
│                                # Snowflake + dbt + Airflow + Metabase + Docker + CI/CD
```

---

## 📦 Projects

### 1. Advanced SQL & BigQuery — `01_cloud_sql_advanced/`

Business SQL queries on an e-commerce fil rouge dataset (orders, products, sellers, users).

**Exercises:**
- **Business queries** — KPIs: orders, products, sellers, customers (LTV, average basket)
- **BigQuery partitioning** — avocado dataset analysis, scan optimization
- **BigQuery audit** — jobs analysis, costs, tables (`INFORMATION_SCHEMA`)
- **Advanced SQL** — Bitcoin volatility analysis, volumes, window functions

**Skills:** `window functions` · `CTEs` · `aggregations` · `query optimization` · `partitioning`

---

### 2. Data Ingestion — `02_Fivetran_Airbyte/`

ELT pipeline setup with managed ingestion tools.

**Exercises:**
- Source connection and configuration with **Fivetran** and **Airbyte Cloud**
- **GA4 events** analysis: ARRAY flattening, sessions, clustering
- Post-ingestion business KPIs

**Skills:** `Fivetran` · `Airbyte` · `GA4` · `UNNEST` · `clustered tables`

---

### 3. dbt Core + CI/CD — `03_dbt/`

Production-grade dbt project with automated CI/CD pipeline on GitHub Actions.

**dbt Architecture:**
```
sources (BigQuery raw data)
    ↓
staging/        stg_airbnb__listings, stg_ga4__event, stg_sales_database__*, stg_spotify__*
    ↓
intermediate/   int_ga4__session, int_sales_database__order/product/seller/user, int_spotify__*
    ↓
mart/           mrt_airbnb__listings_summary, mrt_order_daily_report, mrt_spotify__top_artists
```

**Domains covered:**
| Domain | Models | Description |
|---|---|---|
| Airbnb | 2 models | Price aggregation by neighborhood & room type |
| Sales Database | 12 models | Full e-commerce pipeline |
| GA4 | 2 models | Web session analysis |
| Spotify | 3 models | Top artists by streams |

**dbt features implemented:**
- Materializations: `view`, `table`, `incremental`
- Generic tests (`unique`, `not_null`, `accepted_values`, `relationships`)
- Custom SQL tests & `dbt_expectations`
- Jinja macros (`product_volume_calculation`)
- Seeds (`marketing_budget`)
- `persist_docs` → description propagation to BigQuery
- Variables (`order_status_list`, `payment_type_list`, `room_type_list`)
- Packages: `dbt_utils`, `dbt_expectations`, `dbt_date`

**CI/CD — GitHub Actions:**
- Slim CI with `state:modified+` and `--defer` → only modified models tested
- Isolated BigQuery dataset per PR (`dbt_ci_pr_<number>`)
- Automatic cleanup after each CI run

---

### 4. Local Bike — Full Analytics Engineering Project — `04_local_bike_project/`

End-to-end analytics engineering project on a bike store chain dataset.
From raw CSV ingestion to production dashboards, with full orchestration.

**Objective:** Optimize revenue through data-driven insights on stores, products, and customers.

**Full Pipeline:**
```
CSV Files → Snowflake (raw) → dbt (16 models) → Metabase (dashboard)
```

**dbt Architecture — Star Schema:**
```
Raw (Snowflake)
       ↓
Staging      → 9 view models  (standardization, casting, renaming)
       ↓
Intermediate → 2 view models  (enrichment, revenue metrics, delivery KPIs)
       ↓
Marts        → 5 table models (Star Schema ready for BI)
```

```
              dim_customers
                    |
dim_stores ── fact_sales ── dim_products
                    |
              dim_dates
```

**Data quality:** 96 tests — `not_null`, `unique`, `relationships`, `accepted_values`, `expression_is_true`, singular tests

**BI Dashboard — Metabase:**
- KPIs: Total Revenue, Orders, Average Basket, On-time Delivery Rate
- Revenue analysis by store, category, brand, month
- Product performance: Top 10 products, discount analysis
- Store & Staff performance: delivery delays, order status
- Customer analysis: Top 20 customers, revenue by state & city
- Global filters: date range, store, category, order status

**CI/CD — GitHub Actions:**
- Triggered on every Pull Request targeting `main`
- Jobs: `dbt deps` → `dbt debug` → `dbt build` → auto-cleanup CI schema
- Slim CI with manifest-based selective builds

**Skills:** `Snowflake` · `dbt Core` · `Docker` · `Metabase` · `GitHub Actions` · `Star Schema`

---

## 🛠️ Tech Stack

| Category | Tools |
|---|---|
| **Data Warehouse** | BigQuery (GCP), Snowflake |
| **Transformation** | dbt Core |
| **Ingestion** | Fivetran, Airbyte, Python (snowflake-connector) |
| **BI & Dashboarding** | Metabase (Docker) |
| **CI/CD** | GitHub Actions |
| **Containerization** | Docker, Docker Compose |
| **Versioning** | Git / GitHub |
| **Languages** | SQL, Python, Jinja, YAML |

---

## 💡 Core Skills

**SQL & Data Warehousing**
- Window functions (`ROW_NUMBER`, `RANK`, `LAG`, `LEAD`, `NTILE`)
- CTEs, subqueries, advanced joins (anti-join, self-join)
- BigQuery partitioning & clustering
- `UNNEST` / `ARRAY_AGG` / `STRUCT` — nested data
- Query audit and optimization (`INFORMATION_SCHEMA`)
- Snowflake roles, grants, and user management

**dbt**
- Layered architecture (staging → intermediate → marts)
- Incremental models with late-arriving data handling
- Data quality testing (generic + singular + expectations)
- Full documentation and lineage
- Slim CI/CD with `--defer` and `state:modified+`
- Star schema design for BI consumption

**Data Engineering**
- End-to-end ELT pipeline design
- Containerization with Docker & Docker Compose
- Git versioning (feature branches, PRs, code review)
- CI/CD automation with GitHub Actions
- GCP credentials management (Service Account)

---

## 👤 About (Moussa MBALLO)

Consultant & Civil Engineer transitioning into **Analytics Engineering**.

- Strong analytical background and complex problem-solving skills
- Hands-on experience with real-world, large-scale datasets
- Production-oriented mindset with focus on best practices and data quality

---

## 📬 Contact

- **GitHub**: [github.com/MoussaInc](https://github.com/MoussaInc)