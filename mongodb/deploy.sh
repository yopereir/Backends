export NAMESPACE="mongodb"

kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE

# Deployments
## Deploy vanilla mongodb stack
kubectl apply -R -f ./stack/vanilla --namespace $NAMESPACE
## Deploy bitnami helm chart
#kubectl apply -R -f ./stack/bitnami --namespace $NAMESPACE