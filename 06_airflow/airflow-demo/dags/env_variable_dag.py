from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from datetime import datetime

def message():
    print("This is a message from the PythonOperator!")
    import os
    my_var = os.environ.get('MY_FIRST_ENV_VAR')
    if my_var:
        print(f"Bienvenue, {my_var}!")
    else:
        print("MY_FIRST_ENV_VAR is not set.")

with DAG(
    dag_id='env_variable_dag',
    start_date=datetime(2024, 6, 1),
    schedule_interval='@daily',
    catchup=False
) as dag:

    print_env_variable = BashOperator(
        task_id='print_env_variable',
        bash_command='bash /opt/airflow/plugins/env_script.sh ',
        env={
            'MY_FIRST_ENV_VAR': 'Hello, Airflow DAG!',
            'MY_SECOND_ENV_VAR': '10'
        }
    )

    message_task = PythonOperator(
        task_id='message',
        python_callable=message
    )

    message_task >> print_env_variable