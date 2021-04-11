#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=labola/ml-project:v1

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run ml-project --image=$dockerpath --port=80 --labels app=ml-project

# Step 3:
# List kubernetes pods
kubectl get pods
sleep 5s

# Step 4:
# Forward the container port to a host
kubectl port-forward ml-project 8000:80

# Step 5:
# Get app log
kubectl logs ml-project

