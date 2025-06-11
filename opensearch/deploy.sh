export NAMESPACE="opensearch"
export DYNAMIC_IMAGE_NAME=$NAMESPACE"-test"

while test $# -gt 0; do
  case "$1" in
    -i|--ingress)
      echo "Ingress controller will be installed and port-forwarded to 80."
      kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/cloud/deploy.yaml
      sleep 20
      kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
      sudo kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 80:80
      exit 0
      shift
      ;;
    -fn|--fresh-namespace)
      echo "Namespace will be deleted and re-created."
      kubectl delete namespace $NAMESPACE || echo 0
      shift
      ;;
    *)
      break
      ;;
  esac
done

# Set dns resolution
if $(cat /etc/hosts | grep -q opensearch.test);then
 sudo sed -i -e "s/.*opensearch.test.*/$(echo "127.0.0.1 opensearch.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 opensearch.test" | sudo tee -a /etc/hosts;
fi
if $(cat /etc/hosts | grep -q opensearch.dashboard.test);then
 sudo sed -i -e "s/.*opensearch.dashboard.test.*/$(echo "127.0.0.1 opensearch.dashboard.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 opensearch.dashboard.test" | sudo tee -a /etc/hosts;
fi

# Create k8s namespace
kubectl create namespace $NAMESPACE || echo 0

# Vanilla
## Build custom matomo image
docker build -t $DYNAMIC_IMAGE_NAME --build-arg TRIVY_FAIL=1 ./stacks/vanilla/
## Create secrets
kubectl create secret generic opensearch-secret-env --from-env-file ./stacks/vanilla/.env --namespace $NAMESPACE
kubectl create secret generic opensearch-dashboard-secret-env --from-env-file ./stacks/vanilla/.env.dashboard --namespace $NAMESPACE
## Deoploy k8s resources
find ./stacks/vanilla/ -name '*.yaml' -exec sh -c 'envsubst < "$1" | kubectl apply -f - --namespace $NAMESPACE' _ {} \;