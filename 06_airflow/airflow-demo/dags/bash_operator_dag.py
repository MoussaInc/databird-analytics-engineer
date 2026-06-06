from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

SYSTEM_INFOS = """
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
"""

with DAG(
    dag_id="bash_operator_dag",
    start_date=datetime(2026, 6, 1),
    schedule="0 0 1 * *",  # S'exécute une fois par mois le 1er à minuit
    catchup=False,
    default_args={"owner": "airflow_demo"},
) as dag:

    print_message = BashOperator(
        task_id="print_message",
        bash_command='echo "Hello from Bash!"',
    )

    show_date = BashOperator(
        task_id="show_date",
        bash_command="date",
    )

    list_files = BashOperator(
        task_id="list_files",
        bash_command="ls -lh /opt/airflow/dags",
    )

    system_infos = BashOperator(
        task_id="system_infos",
        bash_command=SYSTEM_INFOS,
    )

    print_message >> [show_date, list_files] >> system_infos