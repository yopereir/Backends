export NAMESPACE="wordpress"

kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE

# Deployments
## Deploy vanilla wordpress stack
kubectl create secret generic wordpress-secret --from-env-file ./secrets/.env --namespace $NAMESPACE
kubectl apply -R -f ./stack/vanilla --namespace $NAMESPACE

# Connect to server from localhost
#kubectl port-forward svc/wordpress-svc 8080:80 --namespace $NAMESPACE