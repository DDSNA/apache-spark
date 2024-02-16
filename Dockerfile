# Use the official Airflow image as the base
FROM apache/airflow:2.2.5

# Install additional Python packages
RUN pip install --no-cache-dir --user my-awesome-pip-dependency-to-add

# If you need to add system-level dependencies, switch to the root user
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends pandas && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the airflow user
USER airflow
EXPOSE 8080
