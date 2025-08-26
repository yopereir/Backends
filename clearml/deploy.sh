export NAMESPACE="clearml"
export ENVIRONMENT="loc"
export DYNAMIC_IMAGE_NAME=$NAMESPACE"-$ENVIRONMENT"
export STACK="simple"

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
if $(cat /etc/hosts | grep -q clearml.test);then
 sudo sed -i -e "s/.*clearml.test.*/$(echo "127.0.0.1 clearml.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 clearml.test" | sudo tee -a /etc/hosts;
fi

# Build docker image
docker build -t $DYNAMIC_IMAGE_NAME -f ./stacks/k8s/$STACK/Dockerfile .

# Create and deploy k8s resources
kubectl create namespace $NAMESPACE


# Deploy helm chart
## Install Helm chart
# helm repo add clearml https://clearml.github.io/clearml-helm-charts
## Generate k8s objects from helm chart
rm -rf ./stacks/helm/generated/*
helm template clearml/clearml --output-dir ./stacks/helm/generated/ -f ./stacks/helm/values.yaml --set fullnameOverride=clearml --namespace $NAMESPACE
## Deploy k8s objects
kubectl apply -R -f ./stacks/helm/generated/* --namespace $NAMESPACE

# View GUI from browser
#kubectl port-forward svc/clearml-webserver 8080:8080 --namespace $NAMESPACE
#kubectl port-forward svc/clearml-apiserver 8008:8008 --namespace $NAMESPACE
#kubectl port-forward svc/clearml-fileserver 8081:8081 --namespace $NAMESPACE