# kind create cluster --config ./stacks/k8s/kind-config.yaml
kubectl create namespace apache-httpd
kubectl create configmap config-modules --from-file=./configs/custom.conf --from-file=./configs/httpd.conf -n apache-httpd
kubectl create secret generic httpd-env --from-env-file=./secrets/.env -n apache-httpd
kubectl apply -f stacks/vanilla.yaml -n apache-httpd
kubectl port-forward svc/apache-httpd -n apache-httpd 11434:11434
