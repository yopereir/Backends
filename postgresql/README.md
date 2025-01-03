# PostgreSQL
PostgreSQL Database stack.

## Deploy
1. With an existing Kubernetes Cluster running, run `./deploy.sh`.
2. This will deploy all the Postgres objects within `generatedCharts` to the Kubernetes cluster under Namespace `postgresql`.
3. This will also deploy a pgadmin service to interact with the PG database via GUI.
4. Default user is `postgres` and password found in `generatedCharts/../secrets.yaml`.