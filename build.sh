# -- Env variables

SPARK_VERSION="3.5.1"

# -- Building the Images

docker build \
  -f cluster-base.Dockerfile \
  -t cluster-base .

docker build \
  --build-arg spark-version="${SPARK_VERSION}" \
  -f spark-base.Dockerfile \
  -t spark-base .

docker build \
  --build-arg pyspark_version="${SPARK_VERSION}" \
  -f jupyterlab.Dockerfile \
  -t jupyterlab .
