kind create cluster --config=stacks/vanilla/kind-config.yaml
docker build -t openwebui --build-arg TAG=main --build-arg TRIVY_FAIL=1 ./stacks/vanilla/
docker build -t openwebui-ollama --build-arg TRIVY_FAIL=1 -f ./stacks/vanilla/Dockerfile.ollama .
kind load docker-image openwebui
kind load docker-image openwebui-ollama
kubectl create namespace openwebui
kubectl create secret generic openwebui-secret-env --from-env-file=./stacks/vanilla/.env --namespace openwebui
kubectl apply -f ./stacks/vanilla/openwebui.yaml -n openwebui
kubectl apply -f ./stacks/vanilla/ollama.yaml -n openwebui
