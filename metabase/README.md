# Metabase
Metabase implementation.

## Conventions
- `stacks` folder contain different implementations of the full metabase stack.
- Within the `stacks` folder, `Dockerfile` contains the base metabase image, `.env` contains the secrets used by metabase and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.