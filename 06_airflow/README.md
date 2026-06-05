# lancer un container local airflow
docker run -d --name airflow \          #Execution du container en arriere plan
    -p 8080:8000 \
    -v ./dags:/opt/airflow/dags \
    -e AIRFLOW__CORE__EXECUTOR=SequentialExecutor \     # Mode d'execution sequentiel, qui evite la necessite du BD externe
    apache/airflow:3.1.7 \                              # Image officielle de AIRFLOW
    standalone

# Initilaisation de la BD (SQlite)
docker exec -it airflow airflow db migrate

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