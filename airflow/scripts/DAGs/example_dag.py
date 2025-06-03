from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta

# Define the function that will be called by the PythonOperator
def say_hello():
    print("Hello from Airflow!")

# Define the DAG
default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    dag_id='example_hello_world_dag',
    default_args=default_args,
    description='A simple hello world DAG',
    start_date=datetime(2024, 1, 1),
    schedule_interval='@daily',  # Run once per day
    catchup=False,
    tags=['example'],
) as dag:

    hello_task = PythonOperator(
        task_id='say_hello_task',
        python_callable=say_hello,
    )

    hello_task  # This defines the task in the DAG
