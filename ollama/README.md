# Ollama
Ollama is an LLM engine that runs LLM models. Can interface with openwebui.

## Conventions
- `stacks` folder contain different implementations of the full ollama stack.
- Within the `stacks` folder, `Dockerfile` contains the base ollama image, `./secrets/.env.ENVIRONMENT` contains the secrets used by ollama and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.

## How Tos
### Get ollama models locally in models folder and within container on Windows
- Run `ollama pull deepseek-r1` to get model.
- Run `xcopy "%USERPROFILE%\.ollama\models" "%CD%\models" /E /I /H /K /Y` to place model in directory.
- Run `docker build -t ollama-loc -f ./stacks/k8s/Dockerfile .` to build image then deploy.
