#!/bin/bash

OUTPUT="/opt/airflow/db/output.txt"

echo "============================="
echo "  Ecriture dans $OUTPUT"
echo "============================="

echo "Hello Airflow, this is a message from a Bash script!" > $OUTPUT

echo "Date d'exécution : $(date)"       >> $OUTPUT
echo "Utilisateur      : $(whoami)"     >> $OUTPUT
echo "Hostname         : $(hostname)"   >> $OUTPUT
echo "Message          : Hello Airflow" >> $OUTPUT
echo "============================="
echo "Fichier écrit avec succès : $OUTPUT"
cat $OUTPUT