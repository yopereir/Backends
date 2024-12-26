export NAMESPACE="rabbitmq"
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
kubectl apply -R -f ./charts/generated/ --namespace $NAMESPACE