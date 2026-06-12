from airflow import DAG
from airflow.sensors.filesystem import FileSensor
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    "owner": "airflow",
    "retries": 1,
    "retry_delay": timedelta(minutes=30),
}

with DAG(
    dag_id="ingestion_dag",
    description="Trigger ingestion if CSV files change or daily fallback run",
    default_args=default_args,
    schedule="0 2 * * *",               # fallback quotidien à 2h du matin
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=["sensor", "snowflake", "ingestion"],
) as dag:

    # Sensor : détecte présence de CSV
    wait_for_csv = FileSensor(
        task_id="wait_for_csv",
        filepath="/opt/airflow/data/",
        fs_conn_id="fs_default",
        poke_interval=60,               # check chaque minute
        timeout=60 * 60 * 1,            # attend max 1h
        mode="reschedule",              # libère worker
    )

    # Ingestion
    run_ingestion = BashOperator(
        task_id="run_ingestion",
        bash_command="python /opt/airflow/ingestion/load_to_warehouse.py",
    )

    wait_for_csv >> run_ingestion