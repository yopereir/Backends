# PostgreSQL
Matomo stack.

## Deploy
1. Have an existing Kubernetes Cluster running with 1 SQL database setup within the matomo namespace.
2. Setup the secrets, config and env vars within the `secrets` folder, `config/custom.ini.php` file and env vars inside `deployment.yaml/secrets.yaml` within `generated` folder respectively.
3. Run `./deploy.sh`. This will build to Matomo image, add `matomo.test` to your hosts file and deploy all objects within `generated` folder to the Kubernetes cluster under Namespace `matomo`.
4. Visit the local matomo site at `matomo.test`.