#!/bin/bash

# Build and push Docker images to Dockerhub
docker build -t nlesc/osmium latest &&
docker build -t nlesc/osmium:develop develop &&
docker push nlesc/osmium &&
echo "Pushed docker repository nlesc/osmium"
