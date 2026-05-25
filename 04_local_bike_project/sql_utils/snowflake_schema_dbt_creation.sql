
USE ROLE ACCOUNTADMIN;

-- création des schema snowflake pour les différents modèles dbt:
CREATE SCHEMA IF NOT EXISTS dbt_db.staging;
CREATE SCHEMA IF NOT EXISTS dbt_db.intermediate;
CREATE SCHEMA IF NOT EXISTS dbt_db.marts;

-- donner accès à dbt_role:
GRANT USAGE ON SCHEMA dbt_db.staging TO ROLE dbt_role;
GRANT USAGE ON SCHEMA dbt_db.intermediate TO ROLE dbt_role;
GRANT USAGE ON SCHEMA dbt_db.marts TO ROLE dbt_role;

-- autoriser la création d'objets:
GRANT CREATE TABLE ON SCHEMA dbt_db.staging TO ROLE dbt_role;
GRANT CREATE VIEW ON SCHEMA dbt_db.staging TO ROLE dbt_role;
GRANT CREATE TABLE ON SCHEMA dbt_db.intermediate TO ROLE dbt_role;
GRANT CREATE VIEW ON SCHEMA dbt_db.intermediate TO ROLE dbt_role;
GRANT CREATE TABLE ON SCHEMA dbt_db.marts TO ROLE dbt_role;
GRANT CREATE VIEW ON SCHEMA dbt_db.marts TO ROLE dbt_role;



DROP SCHEMA IF EXISTS dbt_db.public;
DROP SCHEMA IF EXISTS dbt_db.raw;
USE ROLE ACCOUNTADMIN;
GRANT CREATE SCHEMA ON DATABASE dbt_db TO ROLE dbt_role;