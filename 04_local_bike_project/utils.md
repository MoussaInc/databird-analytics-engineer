# permission necessaire avant le lancement du container
sudo chown -R 1000:0 airflow dbt_analytics data

# Image airflow
docker build -t airflow-dbt-image .

# Demarrer un container
docker run -d \
  --name airflow-dbt-container \
  -p 8080:8080 \
  -e AIRFLOW__CORE__PARALLELISM=1 \
  --env-file $(pwd)/airflow/.env \
  -v $(pwd)/airflow/dags:/opt/airflow/dags \
  -v $(pwd)/airflow/.dbt:/opt/airflow/.dbt \
  -v $(pwd)/airflow/plugins:/opt/airflow/plugins \
  -v $(pwd)/airflow/ingestion:/opt/airflow/ingestion \
  -v $(pwd)/data/localbike_dataset:/opt/airflow/data \
  -v $(pwd)/dbt_analytics:/opt/airflow/dbt_analytics \
  airflow-dbt-image

# Reinitialiser le mot de pass
docker exec -it airflow-dbt-container airflow users reset-password -u admin -p admin1234


