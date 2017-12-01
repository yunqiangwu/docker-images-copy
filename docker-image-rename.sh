#!/bin/bash

# docker pull registry.saas.hand-china.com/google_containers/kubernetes-dashboard-init-amd64:v1.0.0

# docker tag registry.saas.hand-china.com/google_containers/kubernetes-dashboard-init-amd64:v1.0.0 gcr.io/google_containers/kubernetes-dashboard-init-amd64:v1.0.0





  COPY_IMAGES=kubernetes-dashboard-amd64:v1.8.0,pause-amd64:3.0


  - OLD_IFS="$IFS"
  - IFS=","
  - COPY_IMAGES_TO_ARR=($COPY_IMAGES)
  - IFS="$OLD_IFS"
  # - s=kubernetes-dashboard-amd64:v1.8.0
  # - docker pull ${DOCKER_FROM_PROJECT}/${s}
  # - docker tag ${DOCKER_FROM_PROJECT}/${s} ${DOCKER_TO_PROJECT}/${s}
  # - docker push ${DOCKER_TO_PROJECT}/${s}



  - |
    for s in ${COPY_IMAGES_TO_ARR[@]}
    do
      docker pull ${DOCKER_FROM_PROJECT}/${s}
      docker tag ${DOCKER_FROM_PROJECT}/${s} ${DOCKER_TO_PROJECT}/${s}
      docker push ${DOCKER_TO_PROJECT}/${s}
      echo docker push ${DOCKER_TO_PROJECT}/${s}  from   ${DOCKER_FROM_PROJECT}/${s}
    done
  - docker images -a

