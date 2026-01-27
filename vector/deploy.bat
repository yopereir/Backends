# kind create cluster --config ./stacks/k8s/kind-config.yaml
kubectl create namespace vector
kubectl create configmap vector-config --from-file=./configs/vector.yaml -n vector
kubectl create secret generic vector-env --from-env-file=./secrets/.env -n vector
kubectl apply -f stacks/vanilla.yaml -n vector
kubectl port-forward svc/vector -n vector 11434:11434
# Test curl access to the debugger sidecar container: kubectl exec -it vector-695698d4-fl5dd -n vector -c debugger -- curl -v "http://apache-httpd.apache-httpd.svc.cluster.local/server-status?auto"