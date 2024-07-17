FROM cluster-base

ARG jupyterlab_version=4.2.0

RUN pip3 install wget jupyterlab==${jupyterlab_version}

COPY requirements.txt .
RUN pip3 install -r requirements.txt

WORKDIR ${SHARED_WORKSPACE}

CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=
