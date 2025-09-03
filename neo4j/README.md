# Neo4J
Graph database. Has Enterprise and Community edition.

## Conventions
- `stacks` folder contain different implementations of the full neo4j stack.
- Within the `stacks` folder, `Dockerfile` contains the base neo4j image, `./secrets/.env.ENVIRONMENT` contains the secrets used by neo4j and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.