# -- Env variables
SPARK_VERSION="3.5.1"
HADOOP_VERSION="3.5.1"

#
# -- Building the Images

docker build \
  -f cluster-base.Dockerfile \
  -t cluster-base .

docker build \
  -f spark-base.Dockerfile \
  -t spark-base .

docker build \
  -f jupyterlab.Dockerfile \
  -t jupyterlab .
