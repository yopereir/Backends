export NAMESPACE="jupyter"
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
envsubst < $(ls *.yaml) | kubectl apply -f - --namespace $NAMESPACE