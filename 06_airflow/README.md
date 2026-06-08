# 06 — Apache Airflow

## 🚀 Lancer le container

```bash
# Permissions obligatoires avant le premier lancement
sudo chown -R 50000:0 airflow-demo/

docker run -d --name airflow-standalone \
    -p 8080:8080 \
    -e AIRFLOW__CORE__PARALLELISM=1 \
    -e _PIP_ADDITIONAL_REQUIREMENTS="xlrd openpyxl pandas" \
    -v $(pwd)/airflow-demo/dags:/opt/airflow/dags \
    -v $(pwd)/airflow-demo/plugins:/opt/airflow/plugins \
    -v $(pwd)/airflow-demo/logs:/opt/airflow/logs \
    -v $(pwd)/airflow-demo/config:/opt/airflow/config \
    -v $(pwd)/airflow-demo/db:/opt/airflow/db \
    apache/airflow:2.9.2 standalone
```

## 🔑 Mot de passe admin

```bash
docker logs airflow-standalone | grep "Password for user"

# Réinitialiser
docker exec airflow-standalone airflow users reset-password -u admin -p nouveauMotDePasse
```

## 📋 Commandes DAG essentielles

```bash
docker exec airflow-standalone airflow dags list
docker exec airflow-standalone airflow dags list-import-errors
docker exec airflow-standalone airflow dags reserialize
docker exec airflow-standalone airflow tasks list <dag_id>
docker exec airflow-standalone airflow tasks test <dag_id> <task_id> <date>
docker exec airflow-standalone airflow dags trigger <dag_id>
docker exec airflow-standalone airflow dags state <dag_id> <date>
docker exec airflow-standalone airflow dags unpause <dag_id>
```

## ⚠️ Pièges fréquents

| Problème | Solution |
|---|---|
| DAGs absents de l'UI | `airflow dags reserialize` |
| `PermissionError` logs/db | `sudo chown -R 50000:0 airflow-demo/` |
| `TemplateNotFound` sur `.sh` | Ajouter un espace à la fin : `"script.sh "` |
| `state mismatch` | Ajouter `AIRFLOW__CORE__PARALLELISM=1` |
| `ModuleNotFoundError` | Ajouter à `_PIP_ADDITIONAL_REQUIREMENTS` |
| DAG dupliqué | Même `dag_id` dans deux fichiers → supprimer le doublon |