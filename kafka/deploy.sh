export NAMESPACE="kafka"

kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
kubectl apply -R -f ./generated --namespace $NAMESPACE