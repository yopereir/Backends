export NAMESPACE="fluent-bit"
# Clear previous deployment
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE

# Deploy helm chart
## Install Helm chart
# helm repo add fluent https://fluent.github.io/helm-charts
## Generate k8s objects from helm chart
rm -rf ./stacks/helm/generated/*
helm template fluent/fluent-bit --output-dir ./stacks/helm/generated/ -f ./stacks/helm/values.yaml --set fullnameOverride=fluent-bit --namespace $NAMESPACE
## Deploy k8s objects
kubectl apply -R -f ./stacks/helm/generated/* --namespace $NAMESPACE