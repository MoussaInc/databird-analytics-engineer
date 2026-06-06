#!/bin/bash

echo "============================="
echo "  INFORMATIONS SYSTEME"
echo "============================="
echo "Date        : $(date)"
echo "Utilisateur : $(whoami)"
echo "Hostname    : $(hostname)"
echo "Répertoire  : $(pwd)"
echo "OS          : $(uname -a)"
echo "============================="
echo "Fichiers dans /opt/airflow/dags :"
ls -l /opt/airflow/dags
echo "============================="