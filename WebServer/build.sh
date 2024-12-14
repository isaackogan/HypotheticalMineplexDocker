#!/bin/bash

docker buildx use retard-uit

docker buildx build --push \
--platform linux/amd64,linux/arm64 \
--tag isaackogan/mineplex-web-server:latest \
--tag isaackogan/mineplex-web-server:v0.0.1 .