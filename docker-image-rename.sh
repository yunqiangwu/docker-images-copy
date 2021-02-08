#!/bin/bash

# docker pull registry.saas.hand-china.com/google_containers/kubernetes-dashboard-init-amd64:v1.0.0

# docker tag registry.saas.hand-china.com/google_containers/kubernetes-dashboard-init-amd64:v1.0.0 gcr.io/google_containers/kubernetes-dashboard-init-amd64:v1.0.0

# curl -s https://raw.githubusercontent.com/yunqiangwu/docker-images-copy/master/docker-image-rename.sh | sh



# export DOCKER_REGISTRY_HOST=registry.cn-hangzhou.aliyuncs.com
# export DOCKER_USER=username
# export DOCKER_PWD=password

# export DOCKER_FROM_PROJECT=gcr.io/gitpod-io/self-hosted
# export DOCKER_TO_PROJECT=registry.cn-hangzhou.aliyuncs.com/gitpod
# export COPY_IMAGES=content-service,messagebus,node-daemon,server,proxy,registry-facade,theia-server,ws-daemon,ws-manager,ws-manager-bridge,ws-proxy,ws-scheduler,theia-ide,ide/code,supervisor,docker-up,seccomp-profile-installer,blobserve,dashboard,image-builder,service-waiter,db-migrations
# export IMAGES_VERSION=0.6.0



if [[ x$COPY_IMAGES == x ]]; then 
  export COPY_IMAGES=$1
fi

if [[ x$IMAGES_VERSION == x ]]; then 
  export IMAGES_VERSION=latest
fi

if [[ x$COPY_IMAGES == x ]]; then 
  # export COPY_IMAGES=mysql,redis
  echo "not set args"
  exit 1
fi

docker login $DOCKER_REGISTRY_HOST -u $DOCKER_USER -p $DOCKER_PWD

OLD_IFS="$IFS"
IFS=","
COPY_IMAGES_TO_ARR=($COPY_IMAGES)
IFS="$OLD_IFS"


for s in ${COPY_IMAGES_TO_ARR[@]}
do

  export IMAGE_FULL_NAME=${s}

  if [[ ! $IMAGE_FULL_NAME =~ ":" ]]; then 

    export IMAGE_FULL_NAME=${IMAGE_FULL_NAME}:${IMAGES_VERSION}

  fi

  export TO_IMAGE_FULL_NAME=${IMAGE_FULL_NAME/\//-}

  echo ${DOCKER_FROM_PROJECT}/${IMAGE_FULL_NAME} "==>" ${DOCKER_TO_PROJECT}/${TO_IMAGE_FULL_NAME}

  docker pull ${DOCKER_FROM_PROJECT}/${IMAGE_FULL_NAME}
  docker tag ${DOCKER_FROM_PROJECT}/${IMAGE_FULL_NAME} ${DOCKER_TO_PROJECT}/${TO_IMAGE_FULL_NAME}
  docker push ${DOCKER_TO_PROJECT}/${TO_IMAGE_FULL_NAME}

done

# docker images -a 

