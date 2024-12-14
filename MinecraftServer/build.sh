#!/bin/bash

docker buildx use retard-uit

docker buildx build --push \
--platform linux/amd64,linux/arm64 \
--tag isaackogan/mineplex-arcade-server:latest \
--tag isaackogan/mineplex-arcade-server:v0.0.2 .