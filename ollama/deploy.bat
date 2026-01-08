kind create cluster --config ./stacks/k8s/kind-config.yaml
kubectl create namespace ollama
kubectl apply -f stacks/k8s/stack.yaml -n ollama
kubectl port-forward svc/ollama-service -n ollama 11434:11434
