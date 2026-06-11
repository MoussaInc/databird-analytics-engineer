from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    "owner": "airflow",
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="dbt_run",
    default_args=default_args,
    description="Execute dbt run",
    schedule=None,
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=["dbt", "snowflake"],
) as dag:
    
    dbt_deps_task = BashOperator(
        task_id="dbt_deps",
        cwd="/opt/airflow/dbt_analytics",
        bash_command="dbt deps --profiles-dir /opt/airflow/.dbt",
    )

    dbt_run_task = BashOperator(
        task_id="dbt_run_models",
        cwd="/opt/airflow/dbt_analytics",
        bash_command="dbt run --profiles-dir /opt/airflow/.dbt",
    )       

    dbt_deps_task >> dbt_run_task