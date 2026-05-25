-- Super utilisateur pour créer les ressources nécessaires à dbt
USE ROLE ACCOUNTADMIN;

-- Création du warehouse
CREATE WAREHOUSE IF NOT EXISTS dbt_wh
WITH
WAREHOUSE_SIZE = 'x-small'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE;

-- Création de la base de données, du role, du schéma et de l'utilisateur dbt_user ou moussa
CREATE DATABASE IF NOT EXISTS dbt_db;
CREATE ROLE IF NOT EXISTS dbt_role;
CREATE SCHEMA IF NOT EXISTS dbt_db.dbt_schema;
CREATE USER IF NOT EXISTS moussa
    PASSWORD = 'MotDePasseSecure123!'
    DEFAULT_ROLE = dbt_role
    DEFAULT_WAREHOUSE = dbt_wh
    MUST_CHANGE_PASSWORD = FALSE;   

-- Assigner les permissions à dbt_role et l'associer à dbt_user
GRANT ROLE dbt_role TO USER moussa;
GRANT USAGE ON WAREHOUSE dbt_wh TO ROLE dbt_role;
GRANT USAGE ON DATABASE dbt_db TO ROLE dbt_role;
GRANT USAGE ON SCHEMA dbt_db.dbt_schema TO ROLE dbt_role;
GRANT CREATE TABLE ON SCHEMA dbt_db.dbt_schema TO ROLE dbt_role;
GRANT CREATE VIEW ON SCHEMA dbt_db.dbt_schema TO ROLE dbt_role;


