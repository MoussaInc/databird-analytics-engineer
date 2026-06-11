from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'retries': 0,
    'retry_delay': timedelta(minutes=1),
}

with DAG(
    dag_id='dbt_test',
    default_args=default_args,
    description='Exécute uniquement le modèle test_model avec dbt',
    schedule_interval=None,
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=['dbt', 'snowflake', 'test_model']
) as dag:

    dbt_run_test = BashOperator(
        task_id="run_dbt_tests",
        cwd="/opt/airflow/dbt_analytics",
        bash_command="dbt test --profiles-dir /opt/airflow/.dbt",
    )

    dbt_run_test
