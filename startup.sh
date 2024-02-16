#!/bin/sh

# Initialize the Airflow database
airflow db init

# Start the Airflow webserver
airflow webserver
