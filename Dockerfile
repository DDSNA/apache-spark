# Use the official Airflow image as the base
FROM apache/airflow:latest

# Install additional Python packages
RUN pip install --no-cache-dir --user pandas matplotlib numpy

# Switch back to the airflow user
USER airflow

# Expose the webserver port
EXPOSE  8080

# Copy the startup script into the container
COPY startup.sh /startup.sh

# Make the startup script executable
USER root
RUN chmod +x /startup.sh

USER airflow

# Run the startup script
CMD ["/startup.sh"]
