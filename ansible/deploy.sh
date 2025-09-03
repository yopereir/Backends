export NAMESPACE="ansible"
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
if $(cat /etc/hosts | grep -q ansible.test);then
 sudo sed -i -e "s/.*ansible.test.*/$(echo "127.0.0.1 ansible.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 ansible.test" | sudo tee -a /etc/hosts;
fi

# Create and deploy k8s resources
kubectl create namespace $NAMESPACE


# Deploy helm chart
## Install Helm chart
# helm repo add awx-operator https://ansible-community.github.io/awx-operator-helm/
## Generate k8s objects from helm chart
rm -rf ./stacks/helm-awx/generated/*
helm template awx-operator/awx-operator --output-dir ./stacks/helm-awx/generated/ -f ./stacks/helm-awx/values.yaml --set fullnameOverride=ansible --namespace $NAMESPACE
find ./stacks/helm-awx/ -name '*.yaml' -exec sh -c 'envsubst < "$1" | kubectl apply -f - --namespace $NAMESPACE' _ {} \;
## Deploy k8s objects
kubectl apply -R -f ./stacks/helm-awx/generated/* --namespace $NAMESPACE

## Deploy k8s objects
# Build docker image
docker build -t $DYNAMIC_IMAGE_NAME -f ./stacks/k8s/Dockerfile ./stacks/k8s/
find ./stacks/k8s/ -name 'stack.yaml' -exec sh -c 'envsubst < "$1" | kubectl apply -f - --namespace $NAMESPACE' _ {} \;

# View GUI from browser
#kubectl port-forward svc/clearml-webserver 8080:8080 --namespace $NAMESPACE