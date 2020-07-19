#!/bin/bash

set -e 

echo "Building base infra ${BUILD_ID}"

docker run -it -v /var/run/docker.sock:/var/run/docker.sock \
	  -e TargetAccountId="${TARGET_ACCOUNT_ID}" \
	  -e EnvironmentNameUpper="PIPELINE" \
	  -e ServiceName="alpha-base-infra" \
	  alpha-base-infra:b${BUILD_ID} /dist/deploy.sh
