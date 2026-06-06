from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
from etl_concrete_functions import extract, transform, normalize, clean, load

with DAG(
    dag_id="etl_concrete",
    start_date=datetime(2026, 6, 1),
    schedule="@daily",
    catchup=False,
    default_args={"owner": "airflow_demo"},
) as dag:

    extract_task = PythonOperator(task_id="extract", python_callable=extract)
    transform_task = PythonOperator(task_id="transform", python_callable=transform, provide_context=True)
    normalize_task = PythonOperator(task_id="normalize", python_callable=normalize, provide_context=True)
    clean_task = PythonOperator(task_id="clean", python_callable=clean, provide_context=True)
    load_task = PythonOperator(task_id="load", python_callable=load, provide_context=True)

    extract_task >> transform_task >> load_task
    extract_task >> normalize_task >> clean_task >> load_task