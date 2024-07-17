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
