# Obot
MCP Gateway.

## Conventions
- `stacks` folder contain different implementations of the full obot stack.
- Within the `stacks` folder, `Dockerfile` contains the base obot image, `./secrets/.env.ENVIRONMENT` contains the secrets used by obot and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.