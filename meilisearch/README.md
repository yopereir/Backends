# Meilisearch
Meilisearch implementation.

## Conventions
- `stacks` folder contain different implementations of the full meilisearch stack.
- Within the `stacks` folder, `Dockerfile` contains the base meilisearch image, `.env` contains the secrets used by meilisearch and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.

## References
- [Link](https://github.com/meilisearch/meilisearch-kubernetes) to official kubernetes stack and helm chart.