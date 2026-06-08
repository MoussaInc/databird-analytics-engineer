#!/bin/bash

echo "Hello from env_script.sh in localhost"
echo "Current date and time: $(date)"
echo "======================================"
echo "Passage de la variable d'environnement : $MY_FIRST_ENV_VAR"
echo "Utilisateur : $(whoami)"
echo "======================================"

cd /opt/airflow/plugins 

echo "Nombre de fichiers dans le répertoire actuel :"
i=0
for file in *; do
    if [ -f "$file" ]; then
        echo "$file"
        i=$((i + 1))
    fi
done
echo "Total : $i fichiers"
ls -la | wc -l
echo "======================================"
echo "Nbr de fichier estimé avant le lancement du DAG : $MY_SECOND_ENV_VAR"