# lancer un container local airflow
docker run -d --name airflow \          #Execution du container en arriere plan
    -p 8080:8000 \
    -v ./dags:/opt/airflow/dags \
    -e AIRFLOW__CORE__EXECUTOR=SequentialExecutor \     # Mode d'execution sequentiel, qui evite la necessite du BD externe
    apache/airflow:3.1.7 \                              # Image officielle de AIRFLOW
    standalone

    ou docker run -d --name airflow-standalone \
        -p 8080:8080 \
        -e AIRFLOW__CORE__PARALLELISM=1 \
        -e _PIP_ADDITIONAL_REQUIREMENTS="xlrd openpyxl pandas" \
        -v $(pwd)/airflow-demo/dags:/opt/airflow/dags \
        -v $(pwd)/airflow-demo/plugins:/opt/airflow/plugins \
        -v $(pwd)/airflow-demo/logs:/opt/airflow/logs \
        -v $(pwd)/airflow-demo/config:/opt/airflow/config \
        -v $(pwd)/airflow-demo/db:/opt/airflow/db \
        apache/airflow:2.9.2 standalone

    Pour recupere le username et password
    docker logs airflow-standalone
    docker logs airflow-standalone | grep -i password

    Pour reinitialiser le mot de passe:
    docker exec airflow-standalone airflow users reset-password -u admin -p admin123


# Initilaisation de la BD (SQlite)
docker exec -it airflow-standalone airflow db migrate

# Creation d'un utilisation admin pour acceder a literface web
docker exec -it airflow airflow users create \
  --username admin \
  --password TKAwkCFu5PVNqNN8 \         # pour recupere ce paassword generer aleatoire 
                                        # docker logs airflow 2>&1 | grep -i password
                                        # ou docker logs airflow 2>&1 | grep -i admin
                                        # ou encore mieux: docker logs airflow | grep "Password for user 'admin'" -A 1
  --firstname moussa \
  --lastname moussa \
  --role Admin \
  --email admin@admin.com

  # La section precedente n'est plus requise maintenant
  Apres la migration airflow creer automatique un admin user et l'attribuer un mode de passe aleatoire quel'on peut 
  visualiser avec cette commande:
  docker logs airflow | grep "Password for user 'admin'" -A 1


# Forcer le scan du disque (si rien les dags ne s'affichent pas dans l'UI)
  docker exec airflow-standalone airflow dags reserialize
  docker exec airflow-standalone airflow dags list

  ## lister tous les dags disponible:
  docker exec airflow-standalone airflow dags list

  ## Voir les tâches d'un DAG spécifique
  docker exec airflow-standalone airflow tasks list etl_concrete

  ## Déclencher un DAG manuellement
  docker exec airflow-standalone airflow dags trigger etl_concrete

  ## Avec une date d'execution specifique
  docker exec airflow-standalone airflow dags trigger etl_concrete --exec-date 2026-06-06

  ## Vérifier l'état d'un DAG pour une exécution donnée
  docker exec airflow-standalone airflow dags state etl_concrete 2026-06-06
  docker exec airflow-standalone airflow dags list-runs -d etl_concrete

