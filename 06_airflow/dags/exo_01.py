from airflow import DAG
from airflow.providers.standard.operators.empty import EmptyOperator
from airflow.providers.standard.operators.python import PythonOperator
from datetime import datetime

from script_hello import hello


with DAG(
    dag_id="hello_world_dag",
    start_date=datetime(2026, 3, 1),
    schedule="* * * * *",  # toutes les minutes
    catchup=False,
    default_args={
        "owner": "airflow_test",
    },
) as dag:

    start = EmptyOperator(task_id="start_task")

    hello_task = PythonOperator(
        task_id="hello_task",
        python_callable=hello
    )

    end = EmptyOperator(task_id="end_task")

    start >> hello_task >> end