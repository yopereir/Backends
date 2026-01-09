kubectl create namespace n8n
kubectl create secret generic n8n-secret-env --from-env-file=./stacks/vanilla/.env --namespace n8n
kubectl apply -f ./stacks/k8s/n8n.yaml -n n8n
kubectl apply -f ./stacks/k8s/postgres.yaml -n n8n
kubectl apply -f ./stacks/ai/stack.yaml -n n8n
