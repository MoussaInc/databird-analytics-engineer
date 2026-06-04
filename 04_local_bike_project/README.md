# Local Bike — Analytics Engineering Project

![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)
![Metabase](https://img.shields.io/badge/Metabase-509EE3?style=flat&logo=metabase&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?style=flat&logo=githubactions&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![Ngrok](https://img.shields.io/badge/Ngrok-1F1E37?style=flat&logo=ngrok&logoColor=white)

> End-to-end analytics engineering pipeline for a local bike store chain — from raw Snowflake data to production-ready dashboards, with CI/CD and live sharing.

---

## 🏗️ Pipeline

```
Snowflake (raw) → dbt Staging (9 views) → Intermediate (2 views) → Marts (5 tables) → Metabase → Ngrok (shared access)
```

**16 models · 96 tests · Star Schema · CI/CD on every PR**

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

## 📊 Dashboard Highlights

Revenue KPIs · Monthly trends · Store & product performance · Top 20 customers · On-time delivery rate

**Live access (Ngrok):** `https://xxxx.ngrok-free.dev` — shared with collaborators, no deployment needed.

---

## ⚙️ CI/CD — GitHub Actions

On every Pull Request: `dbt deps` → `dbt debug` → `dbt build` (models + tests) → auto-cleanup of CI schema.

---

## 🚀 Quick Start

```bash
git clone https://github.com/MoussaInc/databird-analytics-engineer.git
cd databird-analytics-engineer/04_local_bike_project

# Python env
python -m venv .venv && source .venv/bin/activate
pip install dbt-snowflake

# dbt
cd dbt_analytics/
dbt deps
dbt build                  # run models + tests

# dbt docs
dbt docs generate          # build documentation site
dbt docs serve             # open at http://localhost:8080

# Metabase
cd ../metabase/
docker-compose up -d       # http://localhost:3000

# Share with collaborators
ngrok http 3000            # exposes Metabase publicly
```

Configure `~/.dbt/profiles.yml` with your Snowflake credentials (account, user, password, warehouse, role `DBT_ROLE`).

---

## 🌐 Sharing via Ngrok

Ngrok tunnels your local Metabase to a public HTTPS URL — no server required.

```bash
ngrok config add-authtoken <YOUR_TOKEN>
ngrok http 3000
# → https://xxxx.ngrok-free.dev
```

After launch: set **Site URL** in `Metabase Admin → Settings → General`, then invite collaborators via `Admin → People → Invite someone` (requires Gmail SMTP configured in Admin → Settings → Email).

> ⚠️ URL changes on every restart. Requires your machine to be on.

---

## 🛠️ Tech Stack

| Tool | Role |
|---|---|
| Snowflake | Cloud data warehouse |
| dbt-core | Transformation, testing, documentation |
| Metabase + Docker | BI dashboards |
| GitHub Actions | CI/CD |
| Ngrok | Live dashboard sharing |