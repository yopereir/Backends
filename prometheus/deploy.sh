export NAMESPACE="prometheus"
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
kubectl apply -f . --namespace $NAMESPACE