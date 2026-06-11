FROM apache/airflow:2.9.2-python3.11

USER root
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean

USER airflow
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Je prefere ne pas copier ces volumes dans l'image,
# mais les monter à l'exécution pour éviter de les inclure dans l'image finale
# et pour visualiser les changements et nouveaux dags par exemple en temps réel 
# dans l'UI airflow sans avoir a reconstruire l'image.

# COPY airflow/dags/ /opt/airflow/dags/
# COPY airflow/plugins/ /opt/airflow/plugins/
# COPY airflow/.dbt/ /opt/airflow/.dbt/
# COPY dbt_analytics/ /opt/airflow/dbt_analytics/

WORKDIR /opt/airflow
CMD ["standalone"]