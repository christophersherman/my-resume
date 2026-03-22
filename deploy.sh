#!/bin/bash
set -e

IMAGE="10.0.0.110:30500/resume:$(git rev-parse --short HEAD)"

echo "Building $IMAGE..."
docker build --platform linux/amd64 \
  -t "$IMAGE" \
  -t "10.0.0.110:30500/resume:latest" .

echo "Pushing to registry..."
docker push "$IMAGE"
docker push "10.0.0.110:30500/resume:latest"

echo "Deploying to k3s..."
kubectl apply -f k8s/
kubectl set image deployment/resume -n apps web="$IMAGE"
kubectl rollout status deployment/resume -n apps --timeout=120s

echo "Done! resume.csherman.net deployed."
