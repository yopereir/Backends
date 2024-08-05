# helm template ./fluent-bit-chart/ --output-dir generated --set fullnameOverride=fluent-bit --namespace monitoring
export NAMESPACE="monitoring"
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
kubectl apply -R -f ./generated/* --namespace $NAMESPACE