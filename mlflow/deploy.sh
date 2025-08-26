export NAMESPACE="mlflow"
export ENVIRONMENT="loc"
export DYNAMIC_IMAGE_NAME=$NAMESPACE"-$ENVIRONMENT"

while test $# -gt 0; do
  case "$1" in
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

# Build docker image
docker build -t $DYNAMIC_IMAGE_NAME -f ./stacks/k8s/Dockerfile .

# Create and deploy k8s resources
kubectl create namespace $NAMESPACE


# Deploy k8s objects
kubectl apply -R -f ./stacks/k8s/*.yaml --namespace $NAMESPACE

# View GUI from browser
kubectl port-forward svc/mlflow 5000:5000 --namespace $NAMESPACE
