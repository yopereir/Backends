export NAMESPACE="tiddlywiki"
ingress=false

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$package - attempt to capture frames"
      echo " "
      echo "$package [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                 show this help message"
      echo "-i, --ingress              bool to know if new ingress controller should be used"
      return 0
      ;;
    -i|--ingress)
      ingress=true
      echo "Ingress controller will be installed and port-forwarded to 80."
      shift
      ;;
    *)
      break
      ;;
  esac
done
# Start ingress
if [ $ingress = true ]; then
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/cloud/deploy.yaml
sleep 20
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
sudo kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 80:80
exit 0
fi

kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
envsubst < vanilla.yaml | kubectl apply -f - --namespace $NAMESPACE
kubectl port-forward svc/tiddlywiki 8080:80 -n tiddlywiki