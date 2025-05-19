# OpenWebUI
OpenWebUI implementation.

## Conventions
- `stacks` folder contain different implementations of the full openwebui stack.
- Within the `stacks` folder, `Dockerfile` contains the base openwebui image, `.env` contains the secrets used by openwebui and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.
- `models` this folder contains all the models that will be loaded into the ollama container. This folder should be copied to or from `/root/.ollama/models/` within the ollama container.