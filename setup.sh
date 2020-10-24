#!/bin/bash

apt-get update
apt-get install docker.io
apt-get install awscli
apt-get install jq


echo '{ "features": { "buildkit": true } }' | sudo tee /etc/docker/daemon.json

sudo systemctl restart docker

