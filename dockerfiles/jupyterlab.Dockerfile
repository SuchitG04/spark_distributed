FROM python:3.10-bullseye as python-slim

COPY ./requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

FROM cluster-base

COPY --from=python-slim /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=python-slim /usr/local/bin /usr/local/bin

ARG jupyterlab_version=4.2.0
ARG pyspark_version=3.5.1

RUN pip3 install wget pyspark==${pyspark_version} jupyterlab==${jupyterlab_version}

WORKDIR ${SHARED_WORKSPACE}

CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=
