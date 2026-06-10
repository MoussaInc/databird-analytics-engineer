FROM apache/airflow:2.9.2-python3.11

USER airflow

COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY airflow/dags/ /opt/airflow/dags/
COPY airflow/plugins/ /opt/airflow/plugins/
COPY airflow/.dbt/ /opt/airflow/.dbt/
COPY dbt_analytics/ /opt/airflow/dbt_analytics/

WORKDIR /opt/airflow