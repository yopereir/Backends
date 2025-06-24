# Clickhouse
OLAP data analytics framework.

## Conventions
- `stacks` folder contain different implementations of the full clickhouse stack.
- Within the `stacks` folder, `Dockerfile` contains the base clickhouse image, `./secrets/.env.ENVIRONMENT` contains the secrets used by clickhouse and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.