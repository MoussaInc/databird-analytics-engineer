from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta
from alerts import failure_callback

default_args = {
    "owner": "airflow",
    "retries": 3,
    "retry_delay": timedelta(minutes=5),
    "email": ["databirdformation@gmail.com"],
    "email_on_failure": True,
    "email_on_retry": False,

    "on_failure_callback": failure_callback,
}

with DAG(
    dag_id="dbt_transformation_dag",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False,
    default_args=default_args,
    tags=["dbt"],
) as dag:

    dbt_build = BashOperator(
        task_id="dbt_build",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt build --profiles-dir /opt/airflow/.dbt
        """
    )

    generate_docs = BashOperator(
        task_id="generate_docs",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt docs generate --profiles-dir /opt/airflow/.dbt
        """
    )

    dbt_build >> generate_docs