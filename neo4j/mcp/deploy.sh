export NAMESPACE="neo4j"
export ENVIRONMENT="loc"

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
if $(cat /etc/hosts | grep -q neo4j.test);then
 sudo sed -i -e "s/.*neo4j.test.*/$(echo "127.0.0.1 neo4j.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 neo4j.test" | sudo tee -a /etc/hosts;
fi

# Check if the 'src' directory does not exist
if [ ! -d "src" ]; then
  echo "The 'src' directory does not exist. Cloning the repository..."
  git clone https://github.com/neo4j-contrib/mcp-neo4j.git src
else
  echo "The 'src' directory already exists. Skipping git clone."
fi

# Build docker image
docker build -t mcp-neo4j-cloud-aura-api-$ENVIRONMENT -f ./src/servers/mcp-neo4j-cloud-aura-api/Dockerfile ./src/servers/mcp-neo4j-cloud-aura-api/
docker build -t mcp-neo4j-cypher-$ENVIRONMENT -f ./src/servers/mcp-neo4j-cypher/Dockerfile ./src/servers/mcp-neo4j-cypher/
docker build -t mcp-neo4j-data-modeling-$ENVIRONMENT -f ./src/servers/mcp-neo4j-data-modeling/Dockerfile ./src/servers/mcp-neo4j-data-modeling
docker build -t mcp-neo4j-memory-$ENVIRONMENT -f ./src/servers/mcp-neo4j-memory/Dockerfile ./src/servers/mcp-neo4j-memory

# Create and deploy k8s resources
kubectl create namespace $NAMESPACE
kubectl delete secret mcp-neo4j-cloud-aura-api-secret -n $NAMESPACE
kubectl delete secret mcp-neo4j-cypher-secret -n $NAMESPACE
kubectl delete secret mcp-neo4j-data-modeling-secret -n $NAMESPACE
kubectl delete secret mcp-neo4j-memory-secret -n $NAMESPACE
kubectl create secret generic mcp-neo4j-cloud-aura-api-secret --from-env-file=./secrets/mcp-neo4j-cloud-aura-api/.env.$ENVIRONMENT -n $NAMESPACE
kubectl create secret generic mcp-neo4j-cypher-secret --from-env-file=./secrets/mcp-neo4j-cypher/.env.$ENVIRONMENT -n $NAMESPACE
kubectl create secret generic mcp-neo4j-data-modeling-secret --from-env-file=./secrets/mcp-neo4j-data-modeling/.env.$ENVIRONMENT -n $NAMESPACE
kubectl create secret generic mcp-neo4j-memory-secret --from-env-file=./secrets/mcp-neo4j-memory/.env.$ENVIRONMENT -n $NAMESPACE

# Deploy Kubernetes resources
find ./stacks/k8s/ -name '*.yaml' -exec sh -c 'envsubst < "$1" | kubectl apply -f - --namespace $NAMESPACE' _ {} \;

# View GUI from browser and connect to server
#kubectl port-forward svc/svc-neo4j-mcp-neo4j-cloud-aura-api 8081:8080 -n $NAMESPACE
#kubectl port-forward svc/svc-neo4j-mcp-neo4j-cypher 8082:8080 -n $NAMESPACE
#kubectl port-forward svc/svc-neo4j-mcp-neo4j-data-modeling 8083:8080 -n $NAMESPACE
#kubectl port-forward svc/svc-neo4j-mcp-neo4j-memory 8084:8080 -n $NAMESPACE