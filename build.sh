#!/bin/bash

set -e 

echo "Building base infra ${BUILD_ID}"

docker build --progress=plain \
	     --no-cache \
	     --build-arg BUILD_ID="${BUILD_ID}" \
	     -t alpha-base-infra:b${BUILD_ID} .

