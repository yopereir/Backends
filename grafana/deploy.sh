export NAMESPACE="grafana"
export All_STACKS=true
if [[ $All_STACKS = false ]];then
echo "Deploying only main grafana stack"
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
kubectl apply -R -f ./generated/ --namespace $NAMESPACE
else
echo "Deploying all stacks"
kubectl delete namespace $NAMESPACE $NAMESPACE-loki $NAMESPACE-mimir $NAMESPACE-operator $NAMESPACE-tempo || echo 0
kubectl create namespace $NAMESPACE
kubectl create namespace $NAMESPACE-loki
kubectl create namespace $NAMESPACE-mimir
kubectl create namespace $NAMESPACE-operator
kubectl create namespace $NAMESPACE-tempo
kubectl apply -R -f ./generated/ --namespace $NAMESPACE
kubectl apply -R -f ./loki/generated/ --namespace $NAMESPACE-loki
kubectl apply -R -f ./mimir/generated/ --namespace $NAMESPACE-mimir
kubectl apply -R -f ./operator/generated/ --namespace $NAMESPACE-operator
kubectl apply -R -f ./tempo/generated/ --namespace $NAMESPACE-tempo
fi