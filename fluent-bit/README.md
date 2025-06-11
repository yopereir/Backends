# Fluent-bit
Fluent-bit implementation.

## Conventions
- `stacks` folder contain different implementations of the full fluent-bit stack.
- Within the `stacks` folder, `Dockerfile` if present, contains the base fluent-bit image, `.env` contains the secrets used by fluent-bit and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.

## References
- [Link](https://artifacthub.io/packages/helm/fluent/fluent-bit) to official helm chart.