FROM python:3.10-bullseye as python-slim

COPY ./requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

FROM cluster-base

COPY --from=python-slim /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=python-slim /usr/local/bin /usr/local/bin

ENV SPARK_HOME="/opt/spark"
ENV HADOOP_HOME="/opt/hadoop"

ARG spark_version=3.5.1

RUN mkdir -p ${HADOOP_HOME} && mkdir -p ${SPARK_HOME}

# runtime dir
WORKDIR ${SPARK_HOME}

RUN curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop3.tgz -o spark-${spark_version}-bin-hadoop3.tgz \
 && tar xvzf spark-${spark_version}-bin-hadoop3.tgz --directory /opt/spark --strip-components 1 \
 && rm -rf spark-${spark_version}-bin-hadoop3.tgz

ENV SPARK_VERSION=${spark_version}

ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV SPARK_MASTER="spark://spark-master:7077"
ENV SPARK_MASTER_HOST="spark-master"
ENV SPARK_MASTER_PORT="7077"
ENV PYSPARK_PYTHON="python3"

COPY ./conf/spark-defaults.conf ${SPARK_HOME}/conf

RUN chmod u+x /opt/spark/sbin/* && \
    chmod u+x /opt/spark/bin/*

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

