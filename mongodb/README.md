# MongoDB
MongoDB no-SQL database stack.

## File Structure:
- `stack` directory contains the stacks and helm charts that implement mongodb, each within their own folder.
- `deploy.sh` script deploys the mongodb stack to the connected kubernetes cluster.

## How Tos:
# Generate Bitnami Helm chart again:
- Helm chart [link](https://artifacthub.io/packages/helm/bitnami/mongodb?modal=install).
- `rm -rf stack/bitnami/* && helm template bitnami/mongodb --output-dir stack/bitnami --set auth.rbac.create=false,readinessProbe.enabled=false,livenessProbe.enabled=false,startupProbe.enabled=false,podSecurityContext.enabled=false,containerSecurityContext.enabled=false,persistence.enabled=false,fullnameOverride=mongodb --namespace mongodb`