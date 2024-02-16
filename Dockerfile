# Use the official Airflow image as the base
FROM apache/airflow:2.2.5

# Switch to the root user to install system dependencies
USER root

# Update the package list and install Java Runtime Environment (JRE)
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless && \
    apt-get clean

# Switch back to the airflow user
USER airflow

# Copy your DAGs and other necessary files into the container
COPY ./dags /usr/local/airflow/dags

# Install any additional Python packages you need
RUN pip install your-package-name

# If you need to add other components like Hadoop, Hive, etc., do so here
# COPY hadoop-*.tar.gz /opt/hadoop/
# COPY hive-*.tar.gz /opt/hive/
# COPY gcs-connector-*.jar /opt/hadoop/lib/
