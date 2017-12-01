#!/bin/bash

# docker pull registry.saas.hand-china.com/google_containers/kubernetes-dashboard-init-amd64:v1.0.0

# docker tag registry.saas.hand-china.com/google_containers/kubernetes-dashboard-init-amd64:v1.0.0 gcr.io/google_containers/kubernetes-dashboard-init-amd64:v1.0.0

# curl -s https://raw.githubusercontent.com/yunqiangwu/docker-images-copy/master/docker-image-rename.sh | sh


DOCKER_TO_PROJECT=gcr.io/google_containers
DOCKER_FROM_PROJECT=registry.saas.hand-china.com/google_containers2
RENAME_IMAGES=$1

if [[ x$RENAME_IMAGES == x ]]; then 
  export COPY_IMAGES=mysql,redis
  echo "not set args"
  exit 1
fi

# kube-addon-manager:v6.4-beta.2,kubernetes-dashboard-amd64:v1.8.0,pause-amd64:3.0 


OLD_IFS="$IFS"
IFS=","
RENAME_IMAGES_TO_ARR=($RENAME_IMAGES)
IFS="$OLD_IFS"

for s in ${RENAME_IMAGES_TO_ARR[@]}
do
  docker pull ${DOCKER_FROM_PROJECT}/${s}
  docker tag ${DOCKER_FROM_PROJECT}/${s} ${DOCKER_TO_PROJECT}/${s}

  # docker pull ${DOCKER_FROM_PROJECT}/${s%:*}:latest
  # docker tag ${DOCKER_FROM_PROJECT}/${s} ${DOCKER_TO_PROJECT}/${s%:*}:latest
done
docker images -a 

