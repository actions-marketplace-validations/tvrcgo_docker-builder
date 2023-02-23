#!/bin/sh -l

DFT_TAG=${GITHUB_REF##*/}-${GITHUB_RUN_ID}-$(date +"%s")
TAG=${DOCKER_TAG:-$DFT_TAG}

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin $DOCKER_REGISTRY
docker build ${DOCKER_BUILD_CONTEXT:-.} --file ${DOCKER_FILE:-Dockerfile} --tag $DOCKER_REGISTRY/$DOCKER_REPO:$TAG --tag $DOCKER_REGISTRY/$DOCKER_REPO:latest
docker push $DOCKER_REGISTRY/$DOCKER_REPO:latest

if [[ ! -z $DOCKER_TAG ]]; then
  docker push $DOCKER_REGISTRY/$DOCKER_REPO:$TAG
fi
