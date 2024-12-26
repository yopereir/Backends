export NAMESPACE="openapi-swagger"
export SERVER_NAME="go-gin-server"
while test $# -gt 0; do
  case "$1" in
    -i|--ingress)
      echo "Ingress controller will be installed and port-forwarded to 80."
      kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/cloud/deploy.yaml
      sleep 20
      kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
      sudo kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 80:80
      shift
      ;;
    *)
      break
      ;;
  esac
done

# Set dns resolution
if $(cat /etc/hosts | grep -q openapi-swagger-client.test);then
 sudo sed -i -e "s/.*openapi-swagger-client.test.*/$(echo "127.0.0.1 openapi-swagger-client.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 openapi-swagger-client.test" | sudo tee -a /etc/hosts;
fi
if $(cat /etc/hosts | grep -q openapi-swagger-server.test);then
 sudo sed -i -e "s/.*openapi-swagger-server.test.*/$(echo "127.0.0.1 openapi-swagger-server.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 openapi-swagger-server.test" | sudo tee -a /etc/hosts;
fi

kubectl delete namespace $NAMESPACE || echo 0
rm -rf ./$SERVER_NAME
docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli generate -g $SERVER_NAME -o /local/$SERVER_NAME -i /local/api.yaml
docker build -t $SERVER_NAME ./$SERVER_NAME
kubectl create namespace $NAMESPACE
kubectl create configmap api-definition --from-file ./api.yaml --namespace $NAMESPACE
envsubst < k8s.yaml | kubectl apply -f - --namespace $NAMESPACE