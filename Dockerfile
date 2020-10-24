# syntax = docker/dockerfile:experimental
ARG BUILD_ID
#ARG PROJECT_NAME=alpha-base-infra

FROM alphaprosoft/ansible-img:b88

ENV BUILD_ID ${BUILD_ID}




