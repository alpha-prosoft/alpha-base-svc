#!/bin/bash


#export TARGET=ubuntu@${1}
#export DOCKER_HOST=ssh://${TARGET}
export BUILD_ID="3"

export TARGET_ACCOUNT_ID="$(aws sts get-caller-identity | jq -r '.Account')"

./build.sh && ./run.sh
