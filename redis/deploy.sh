export NAMESPACE="redis"

kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE

# Deployments
## Deploy vanilla redis stack
kubectl apply -R -f ./stack/vanilla --namespace $NAMESPACE
## Deploy bitnami helm chart
#kubectl apply -R -f ./stack/bitnami --namespace $NAMESPACE
