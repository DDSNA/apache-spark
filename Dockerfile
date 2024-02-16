# Use the official Airflow image as the base
FROM apache/airflow:latest

# Install additional Python packages
RUN pip install --no-cache-dir --user pandas matplotlib numpy

# Switch back to the airflow user
USER airflow

# Expose the webserver port
EXPOSE  8080

# Set the default command to run the webserver
CMD ["sh", "-c", "airflow db init && airflow webserver"]
