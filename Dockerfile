# Use the official Airflow image as the base
FROM apache/airflow:2.2.5

# Install additional Python packages
RUN pip install --no-cache-dir --user pandas matplotlib numpy


# Switch back to the airflow user
USER airflow
CMD webserver
EXPOSE 8080
