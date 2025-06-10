export NAMESPACE="meilisearch"
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
if $(cat /etc/hosts | grep -q meilisearch.test);then
 sudo sed -i -e "s/.*meilisearch.test.*/$(echo "127.0.0.1 meilisearch.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 meilisearch.test" | sudo tee -a /etc/hosts;
fi

# build custom meilisearch image
docker build -t $DYNAMIC_IMAGE_NAME --build-arg TRIVY_FAIL=1 ./stacks/k8s/

# create and deploy k8s resources
kubectl create namespace $NAMESPACE || echo 0
find ./stacks/k8s/ -name '*.yaml' -exec sh -c 'envsubst < "$1" | kubectl apply -f - --namespace $NAMESPACE' _ {} \;
