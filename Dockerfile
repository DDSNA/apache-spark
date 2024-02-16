FROM python:3.10-bullseye as spark-base

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo \
      curl \
      vim \
      unzip \
      rsync \
      openjdk-11-jdk \
      build-essential \
      software-properties-common \
      ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Spark environment variables
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}

# Create directories for Spark and Hadoop
RUN mkdir -p ${HADOOP_HOME} && mkdir -p ${SPARK_HOME}
WORKDIR ${SPARK_HOME}

# Download and install Spark
RUN curl https://dlcdn.apache.org/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3.tgz -o spark-3.3.1-bin-hadoop3.tgz \
 && tar xvzf spark-3.3.1-bin-hadoop3.tgz --directory /opt/spark --strip-components  1 \
 && rm -rf spark-3.3.1-bin-hadoop3.tgz

# Install Python dependencies
COPY requirements/requirements.txt .
RUN pip3 install -r requirements.txt

# Set Spark configurations and paths
ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV SPARK_HOME="/opt/spark"
ENV SPARK_MASTER="spark://spark-master:7077"
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT  7077
ENV PYSPARK_PYTHON python3

# Copy Spark configuration files
COPY conf/spark-defaults.conf "$SPARK_HOME/conf"

# Set execute permissions
RUN chmod u+x /opt/spark/sbin/* && \
    chmod u+x /opt/spark/bin/*

# Set Python path
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

# Copy entrypoint script
COPY entrypoint.sh .

# Set the entrypoint
ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 7077 8080 22 6066
