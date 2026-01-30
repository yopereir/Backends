kubectl create namespace n8n
kubectl create secret generic n8n-secret --from-env-file=./secrets/.env --namespace n8n
@REM kubectl apply -f ./stacks/k8s/n8n.yaml -n n8n
@REM kubectl apply -f ./stacks/k8s/postgres.yaml -n n8n
@REM OR
kubectl apply -f ./stacks/k8s/n8n-externalDB.yaml -n n8n
@REM kubectl apply -f ./stacks/ai/stack.yaml -n n8n
