export NAMESPACE="grafana-vanilla"
export DYNAMIC_IMAGE_NAME="grafana-custom"
echo "Deploying vanilla stack on same namespace: $NAMESPACE"
# Delete all resources
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE

# Deploy stack
docker build -t $DYNAMIC_IMAGE_NAME --build-arg TRIVY_FAIL=1 ./vanilla
kubectl create secret generic grafana-secrets --from-env-file=./vanilla/secrets/.env --namespace $NAMESPACE
envsubst < ./vanilla/stack/deployment.yaml | kubectl apply -f - --namespace $NAMESPACE