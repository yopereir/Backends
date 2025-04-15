helm repo add kuma https://kumahq.github.io/charts
helm repo update
helm install --create-namespace --namespace kuma-system kuma kuma/kuma
kubectl apply -f https://raw.githubusercontent.com/kumahq/kuma-counter-demo/master/demo.yaml
kubectl apply -f kuma-custom.yaml