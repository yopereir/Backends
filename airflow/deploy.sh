export NAMESPACE="airflow"
echo "Deploying airflow stack on same namespace: $NAMESPACE"
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
# UNCOMMENT TO REINSTALL HELM CHART
# rm -rf generated
# helm repo add apache-airflow https://airflow.apache.org
# helm repo update
# helm template --output-dir ./generated apache-airflow/airflow --set auth.rbac.create=false,readinessProbe.enabled=false,livenessProbe.enabled=false,startupProbe.enabled=false,podSecurityContext.enabled=false,containerSecurityContext.enabled=false,fullnameOverride=airflow --name-template airflow --set webserverSecretKey=c24e0aed99965cf0c4cbe66a8d1d79d3 --namespace $NAMESPACE
docker build -t airflow-test .
kubectl apply -R -f ./generated/ --namespace $NAMESPACE

# Port Forward
# kubectl port-forward --namespace $NAMESPACE svc/airflow-webserver 8080:8080