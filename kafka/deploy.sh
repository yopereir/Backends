export NAMESPACE="kafka"

kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
# DEPLOY HELM CHART- BITNAMI
# kubectl apply -R -f ./stacks/helm/bitnami/templates/ --namespace $NAMESPACE

# DEPLOY Kubernetes simple with GUI
kubectl apply -R -f ./stacks/k8s/simple/ --namespace $NAMESPACE

# View GUI from browser
kubectl port-forward --namespace $NAMESPACE svc/kafka-ui 8080:80