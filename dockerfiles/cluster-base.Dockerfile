# base image with linux+python
FROM python:3.10-bullseye AS cluster-base

ARG shared_workspace=/opt/workspace

RUN apt-get update --allow-unauthenticated --allow-insecure-repositories && \
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

ENV SHARED_WORKSPACE=${shared_workspace}

VOLUME ${shared_workspace}

CMD ["bash"]
