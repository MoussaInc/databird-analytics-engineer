from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="bash_operator_dag_bis",
    start_date=datetime(2026, 6, 1),
    schedule="@hourly",
    catchup=False,
    default_args={"owner": "airflow_demo"},
) as dag:
    
    hello_task = BashOperator(
        task_id="hello_task",
        bash_command="/opt/airflow/plugins/hello_script.sh "
    )

    write_file_task = BashOperator(
        task_id="write_file_task",
        bash_command="/opt/airflow/plugins/write_file.sh "
    )   

    hello_task >> write_file_task
