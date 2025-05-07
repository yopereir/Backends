# Redis
Redis in-memory database stack.

## File Structure:
- `stack` directory contains the stacks and helm charts that implement redis, each within their own folder.
- `deploy.sh` script deploys the redis stack to the connected kubernetes cluster.

## How Tos:
# Generate Bitnami Helm chart again:
- Helm chart [link](https://artifacthub.io/packages/helm/bitnami/redis?modal=install).
- `rm -rf stack/bitnami/* && helm template bitnami/redis --output-dir stack/bitnami --set auth.rbac.create=false,readinessProbe.enabled=false,livenessProbe.enabled=false,startupProbe.enabled=false,podSecurityContext.enabled=false,containerSecurityContext.enabled=false,primary.persistence.enabled=false,fullnameOverride=redis --namespace redis`