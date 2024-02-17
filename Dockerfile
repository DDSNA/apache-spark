# Use the official Apache Airflow image as the base image
FROM apache/airflow:2.8.1-python3.8

# Install any additional system libraries or Python packages
# For example, to install the 'requests' Python library, you can use:
RUN pip install requests matplotlib

# Copy any additional files or directories into the image
# For example, to copy a custom configuration file:
# COPY ./custom-airflow.cfg /opt/airflow/airflow.cfg

# Set any environment variables
# For example, to set the AIRFLOW_HOME environment variable:
ENV AIRFLOW_HOME /opt/airflow
CMD ["airflow","db","init"]
