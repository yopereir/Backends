export NAMESPACE="postgresql"

kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
kubectl apply -f ./pgadmin.yaml --namespace $NAMESPACE
kubectl apply -R -f ./generatedCharts --namespace $NAMESPACE