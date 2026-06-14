from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from datetime import datetime, timedelta
from alerts import failure_callback

default_args = {
    "owner": "airflow",
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
    "email": ["databirdformation@gmail.com"],
    "email_on_failure": True,
    "email_on_retry": False,
    "on_failure_callback": failure_callback,
}

with DAG(
    dag_id="ingestion_dag",
    start_date=datetime(2026, 1, 1),
    schedule="@daily",
    catchup=False,
    default_args=default_args,
    tags=["ingestion", "snowflake"],
) as dag:

    ingest_files = BashOperator(
        task_id="ingest_files",
        bash_command="python /opt/airflow/ingestion/load_to_warehouse.py"
    )

    trigger_dbt = TriggerDagRunOperator(
        task_id="trigger_dbt_pipeline",
        trigger_dag_id="dbt_transformation_dag",
        wait_for_completion=False,
    )

    ingest_files >> trigger_dbt