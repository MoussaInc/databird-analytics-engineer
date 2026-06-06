from airflow import DAG
# from airflow.operators.dummy import DummyOperator 
from airflow.operators.empty import EmptyOperator
from datetime import datetime


with DAG(
    dag_id="my_first_dag",
    start_date=datetime(2026, 3, 1),
    schedule="* * * * *",  # toutes les minutes
    catchup=False,
    default_args={
        "owner": "airflow_demo",
    },
) as dag:

    start = EmptyOperator(task_id="start")
    end = EmptyOperator(task_id="end")

    start >> end