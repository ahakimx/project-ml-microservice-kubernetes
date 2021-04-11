#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath=7c4e2eaf29bd

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker tag $dockerpath labola/ml-project:v1

# Step 3:
# Push image to a docker repository
docker push labola/ml-project:v1
