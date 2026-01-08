export NAMESPACE="openwebui"
export DYNAMIC_IMAGE_NAME=$NAMESPACE
export DYNAMIC_IMAGE_NAME_OLLAMA=$NAMESPACE"-ollama"

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
if $(cat /etc/hosts | grep -q openwebui.test);then
 sudo sed -i -e "s/.*openwebui.test.*/$(echo "127.0.0.1 openwebui.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 openwebui.test" | sudo tee -a /etc/hosts;
fi

# create and deploy k8s resources
kubectl create namespace $NAMESPACE || echo 0

# VANILLA
## build custom images
docker build -t $DYNAMIC_IMAGE_NAME --build-arg TAG=main --build-arg TRIVY_FAIL=1 ./stacks/vanilla/
docker build -t $DYNAMIC_IMAGE_NAME_OLLAMA --build-arg TRIVY_FAIL=1 -f ./stacks/vanilla/Dockerfile.ollama .
## deploy stacks
kubectl create secret generic openwebui-secret-env --from-env-file=./stacks/vanilla/.env --namespace $NAMESPACE
find ./stacks/vanilla/ -name '*.yaml' -exec sh -c 'envsubst < "$1" | kubectl apply -f - --namespace $NAMESPACE' _ {} \;

# HELM
#rm -rf ./stacks/helm
#helm template open-webui/open-webui --output-dir ./stacks/helm --set auth.rbac.create=false,fullnameOverride=openwebui --namespace openwebui
#find ./stacks/helm/ -name '*.yaml' -exec sh -c 'envsubst < "$1" | kubectl apply -f - --namespace $NAMESPACE' _ {} \;

# Port Forward
#kubectl port-forward --namespace $NAMESPACE svc/open-webui-service 8080:80