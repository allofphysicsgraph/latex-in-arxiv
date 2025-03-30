from __future__ import annotations

import pendulum

from airflow.models.dag import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator


def extract_data():
    """
    Simulates extracting data from a source.  In a real-world scenario,
    this would involve reading from a database, API, or file.
    """
    data = ["data1", "data2", "data3"]  # Replace with your actual data extraction
    return data


def transform_data(data):
    """
    Simulates transforming the extracted data.  This could involve cleaning,
    filtering, or enriching the data.
    """
    transformed_data = [item.upper() for item in data]  # Example transformation
    return transformed_data


def load_data(transformed_data):
    """
    Simulates loading the transformed data into a destination.  This might
    involve writing to a database, API, or file.
    """
    print(f"Loading data: {transformed_data}")  # Replace with your actual loading logic


with DAG(
    dag_id="simple_etl_dag",
    # Use a cron expression (e.g., "0 0 * * *") or a timedelta for scheduling
    schedule="* * * * *",
    start_date=pendulum.datetime(2025, 3, 12, tz="UTC"),
    catchup=False,
    tags=["etl", "example"],
) as dag:
    extract = PythonOperator(
        task_id="extract_data",
        python_callable=extract_data,
    )

    transform = PythonOperator(
        task_id="transform_data",
        python_callable=transform_data,
        op_kwargs={"data": extract.output},
        # Pass the output of the extract task as an argument
    )

    load = PythonOperator(
        task_id="load_data",
        python_callable=load_data,
        op_kwargs={"transformed_data": transform.output},
        # Pass the output of the transform task as an argument
    )

    # Optional Bash Operator to represent loading a file
    write_file = BashOperator(
        task_id="write_transformed_data_to_file",
        bash_command="echo '{{ ls }}' > /tmp/transformed_data.txt",
        dag=dag,
    )

    extract >> transform >> load >> write_file  # Define the task dependencies
