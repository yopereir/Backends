export NAMESPACE="duckdb"
export ENVIRONMENT="loc"
export DYNAMIC_IMAGE_NAME=$NAMESPACE"-$ENVIRONMENT"

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
if $(cat /etc/hosts | grep -q duckdb.test);then
 sudo sed -i -e "s/.*duckdb.test.*/$(echo "127.0.0.1 duckdb.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 duckdb.test" | sudo tee -a /etc/hosts;
fi

# Build docker image
docker build -t $DYNAMIC_IMAGE_NAME -f ./Dockerfile .

# Create and deploy k8s resources
kubectl create namespace $NAMESPACE

## Deploy k8s objects
find ./ -name '*.yaml' -exec sh -c 'envsubst < "$1" | kubectl apply -f - --namespace $NAMESPACE' _ {} \;

# View GUI from browser
#kubectl port-forward svc/duckdb-ui-service 8080:80 --namespace $NAMESPACE