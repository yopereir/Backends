export NAMESPACE="kong"
echo "Deploying kong stack on same namespace: $NAMESPACE"
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
# UNCOMMENT TO REINSTALL HELM CHART
# rm -rf generated
# helm repo add kong https://charts.konghq.com
# helm repo update
# helm template --output-dir ./generated kong/kong --set auth.rbac.create=false,fullnameOverride=kong --name-template kong --namespace $NAMESPACE
# helm template --output-dir ./generated kong/ingress --set env.kong_admin_url=https://localhost:8444,auth.rbac.create=false,startupProbe.enabled=false,podSecurityContext.enabled=false,containerSecurityContext.enabled=false,fullnameOverride=kong --name-template kong --namespace $NAMESPACE
# helm template --output-dir ./generated kong/gateway-operator --set env.kong_admin_url=https://localhost:8444,ingressController.env.kong_admin_url=https://localhost:8444,auth.rbac.create=false,startupProbe.enabled=false,podSecurityContext.enabled=false,containerSecurityContext.enabled=false,fullnameOverride=kong --set installCRDs=true --include-crds --dependency-update --name-template kong --namespace $NAMESPACE

# Deploy generated charts
helm install kong/ingress -f values.yaml --generate-name --namespace $NAMESPACE
kubectl create -R -f ./generated/ --namespace $NAMESPACE