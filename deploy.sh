#!/bin/bash

# Stop and remove any running container with the same name if any
docker stop ascii-art-container 2>/dev/null || true
docker rm ascii-art-container 2>/dev/null || true

# Remove the previous image
docker rmi ascii-art-web-server:1.0 2>/dev/null || true

# Build the Docker image
docker build -t ascii-art-web-server:1.0 .

# Run the Docker container
docker run -d -p 8080:8080 --name ascii-art-container ascii-art-web-server:1.0

# Prune unused Docker objects
docker system prune -f
