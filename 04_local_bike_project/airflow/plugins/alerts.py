from airflow.utils.email import send_email


def failure_callback(context):
    dag_id = context["dag"].dag_id
    task_id = context["task_instance"].task_id
    run_id = context["run_id"]
    execution_date = context["execution_date"]
    log_url = context["task_instance"].log_url

    exception = context.get("exception")

    subject = f"[AIRFLOW] Failure - {dag_id}"

    html_content = f"""
        <h2 style="color:red;">Airflow Task Failed</h2>

        <b>DAG:</b> {dag_id}<br>
        <b>Task:</b> {task_id}<br>
        <b>Run ID:</b> {run_id}<br>
        <b>Execution date:</b> {execution_date}<br><br>

        <b>Log URL:</b> <a href="{log_url}">{log_url}</a><br><br>

        <b>Error:</b><br>
        <pre>{exception}</pre>
    """

    send_email(
        to=["databirdformation@gmail.com"],
        subject=subject,
        html_content=html_content,
    )