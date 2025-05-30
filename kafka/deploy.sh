export NAMESPACE="kafka"

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
if $(cat /etc/hosts | grep -q kafka.test);then
 sudo sed -i -e "s/.*kafka.test.*/$(echo "127.0.0.1 kafka.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 kafka.test" | sudo tee -a /etc/hosts;
fi

# Create and deploy k8s resources
kubectl create namespace $NAMESPACE

# deploy HELM CHART- BITNAMI
# kubectl apply -R -f ./stacks/helm/bitnami/templates/ --namespace $NAMESPACE

# deploy Kubernetes simple with GUI
kubectl apply -R -f ./stacks/k8s/simple/ --namespace $NAMESPACE

# View GUI from browser
kubectl port-forward --namespace $NAMESPACE svc/kafka-ui 8080:80