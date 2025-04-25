export NAMESPACE="lgtm"
export All_STACKS=true
echo "Deploying LGTM stack on same namespace: $NAMESPACE"
kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
# UNCOMMENT TO REINSTALL HELM CHART
# rm -rf lgtm
# helm template --output-dir ./lgtm/generated grafana/lgtm-distributed --set auth.rbac.create=false,readinessProbe.enabled=false,livenessProbe.enabled=false,startupProbe.enabled=false,podSecurityContext.enabled=false,containerSecurityContext.enabled=false,fullnameOverride=lgtm --namespace $NAMESPACE
kubectl apply -R -f ./lgtm/generated/ --namespace $NAMESPACE