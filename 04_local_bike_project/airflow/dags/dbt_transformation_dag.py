from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.sensors.external_task import ExternalTaskSensor
from datetime import datetime, timedelta

default_args = {
    "owner": "airflow",
    "retries": 1,
    "retry_delay": timedelta(minutes=30),
}

with DAG(
    dag_id="dbt_transformation_dag",
    start_date=datetime(2026, 1, 1),
    schedule="0 4 * * *",               # 2h après ingestion
    catchup=False,
    default_args=default_args,
    tags=["dbt", "snowflake"],
) as dag:

    wait_for_ingestion = ExternalTaskSensor(
        task_id="wait_for_ingestion",
        external_dag_id="ingestion_dag",
        allowed_states=["success"],
        failed_states=["failed"],
        mode="reschedule",
        timeout=3600,
    )

    run_dbt_deps = BashOperator(
        task_id="run_dbt_deps",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt deps --profiles-dir /opt/airflow/.dbt/
        """,
    )

    run_dbt_seed = BashOperator(
        task_id="run_dbt_seed",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt seed --profiles-dir /opt/airflow/.dbt/
        """,
    )

    run_staging_task = BashOperator(
        task_id="run_staging_task",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt run --select staging --target stage --profiles-dir /opt/airflow/.dbt/
        """,
    )

    test_staging_task = BashOperator(
        task_id="test_staging_task",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt test --select staging --target stage --profiles-dir /opt/airflow/.dbt/
        """,
    )

    run_intermediate_task = BashOperator(
        task_id="run_intermediate_task",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt run --select intermediate --target stage --profiles-dir /opt/airflow/.dbt/
        """,
    )

    test_intermediate_task = BashOperator(
        task_id="test_intermediate_task",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt test --select intermediate --target stage --profiles-dir /opt/airflow/.dbt/
        """,
    )

    run_marts_task = BashOperator(
        task_id="run_marts_task",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt run --select marts --target stage --profiles-dir /opt/airflow/.dbt/
        """,
    )

    test_marts_task = BashOperator(
        task_id="test_marts_task",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt test --select marts --target stage --profiles-dir /opt/airflow/.dbt/
        """,
    )

    docs_task = BashOperator(
        task_id="generate_dbt_docs",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt docs generate --target stage --profiles-dir /opt/airflow/.dbt
        """,
    )

    docs_serve_task = BashOperator(
        task_id="serve_dbt_docs",
        bash_command="""
        cd /opt/airflow/dbt_analytics &&
        dbt docs serve --target stage --profiles-dir /opt/airflow/.dbt
        """,
    )

    (
        wait_for_ingestion >> 
        run_dbt_deps >> run_dbt_seed >>
        run_staging_task >> test_staging_task >>
        run_intermediate_task >> test_intermediate_task >>
        run_marts_task >> test_marts_task >>
        docs_task >> docs_serve_task
    )