# Data Analytics Engineering Portfolio — Moussa MBALLO

> Analytics Engineer portfolio: SQL avancé, ingestion de données, transformation dbt et CI/CD sur GCP/BigQuery.

---

## 🗂️ Structure du projet

```
databird-analytics-engineer/
├── 01_cloud_sql_advanced/     # SQL avancé & BigQuery
├── 02_Fivetran_Airbyte/       # Ingestion de données (ELT)
├── 03_dbt/                    # Transformation dbt Core + CI/CD
├── ....

```

---

## 📦 Projets

### 1. SQL Avancé & BigQuery — `01_cloud_sql_advanced/`

Requêtes SQL métier sur un dataset e-commerce fil rouge (orders, products, sellers, users).

**Exercices réalisés :**
- **Business queries** — KPIs commandes, produits, vendeurs, clients (LTV, panier moyen)
- **Partitionnement BigQuery** — analyse avocado, optimisation des scans
- **Audit BigQuery** — analyse des jobs, coûts, tables (`INFORMATION_SCHEMA`)
- **SQL avancé** — analyse de volatilité Bitcoin, volumes, window functions

**Compétences :** `window functions` · `CTEs` · `agrégations` · `optimisation` · `partitionnement`

---

### 2. Ingestion de données — `02_Fivetran_Airbyte/`

Mise en place de pipelines ELT avec des outils d'ingestion managés.

**Exercices réalisés :**
- Connexion et configuration de sources avec **Fivetran** et **Airbyte Cloud**
- Analyse des événements **GA4** : flatten des ARRAY, sessions, clustering
- KPIs business post-ingestion

**Compétences :** `Fivetran` · `Airbyte` · `GA4` · `UNNEST` · `tables clusterisées`

---

### 3. dbt Core + CI/CD — `03_dbt/`

Projet dbt complet en production avec pipeline CI/CD automatisé sur GitHub Actions.

**Architecture du projet dbt :**
```
sources (BigQuery raw data)
    ↓
staging/        stg_airbnb__listings, stg_ga4__event, stg_sales_database__*, stg_spotify__*
    ↓
intermediate/   int_ga4__session, int_sales_database__order/product/seller/user, int_spotify__*
    ↓
mart/           mrt_airbnb__listings_summary, mrt_order_daily_report, mrt_spotify__top_artists
```

**Domaines couverts :**
| Domaine | Modèles | Description |
|---------|---------|-------------|
| Airbnb | `stg_airbnb__listings`, `mrt_airbnb__listings_summary` | Agrégat prix par quartier & type de logement |
| Sales Database | 7 modèles staging + 4 intermediate + 1 mart | Pipeline e-commerce complet |
| GA4 | `stg_ga4__event`, `int_ga4__session` | Analyse sessions web |
| Spotify | `stg_spotify__*`, `mrt_spotify__top_artists` | Top artistes par écoute |

**Features dbt implémentées :**
- Matérialisations : `view`, `table`, `incremental`
- Tests génériques (`unique`, `not_null`, `accepted_values`, `relationships`)
- Tests custom SQL et `dbt_expectations`
- Macros Jinja (`product_volume_calculation`)
- Seeds (`marketing_budget`)
- `persist_docs` → propagation des descriptions à BigQuery
- Variables (`order_status_list`, `payment_type_list`, `room_type_list`)
- Packages : `dbt_utils`, `dbt_expectations`, `dbt_date`

**CI/CD avec GitHub Actions :**
```yaml
Pull Request → GitHub Actions → dbt build → BigQuery CI dataset → Tests → Cleanup
```
- Slim CI avec `state:modified+` et `--defer` → seuls les modèles modifiés sont testés
- Dataset BigQuery isolé par PR (`dbt_ci_pr_<number>`)
- Nettoyage automatique post-CI

---

## 🛠️ Stack Technique

| Catégorie | Outils |
|-----------|--------|
| Data Warehouse | BigQuery (GCP) |
| Transformation | dbt Core (dbt-fusion 2.0) |
| Ingestion | Fivetran, Airbyte |
| CI/CD | GitHub Actions |
| Versioning | Git / GitHub |
| Langages | SQL, Jinja, YAML, Python |
| Authentification GCP | Service Account |

---

## 💡 Compétences

**SQL & BigQuery**
- Window functions (`ROW_NUMBER`, `RANK`, `LAG`, `LEAD`, `NTILE`)
- CTEs, sous-requêtes, jointures avancées (anti-join, self-join)
- Partitionnement & clustering BigQuery
- `UNNEST` / `ARRAY_AGG` / `STRUCT` — données imbriquées
- Audit et optimisation de requêtes (`INFORMATION_SCHEMA`)

**dbt**
- Architecture en couches (staging → intermediate → mart)
- Modèles incrementaux avec gestion des late-arriving data
- Tests de qualité des données (générique + singulier + expectations)
- Documentation et lineage complet
- CI/CD slim avec `--defer` et `state:modified+`

**Data Engineering**
- Design de pipelines ELT modernes
- Versionning et collaboration Git (feature branches, PRs, code review)
- Automatisation CI/CD avec GitHub Actions
- Gestion des credentials GCP (Service Account, Secret Manager)

---

## 👤 À propos

Consultant & Ingénieur Civil en reconversion vers l'**Analytics Engineering**.

- Solide background analytique et résolution de problèmes complexes
- Expérience avec des datasets réels de grande volumétrie
- Approche rigoureuse, orientée production et bonnes pratiques

---

## 📬 Contact

- **GitHub** : [github.com/MoussaInc](https://github.com/MoussaInc)