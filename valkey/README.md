# Valkey
Valkey in-memory database stack.

## File Structure:
- `stack` directory contains the stacks and helm charts that implement valkey, each within their own folder.
- `deploy.sh` script deploys the valkey stack to the connected kubernetes cluster.

## How Tos:
# Generate Bitnami Helm chart again:
- Helm chart [link](https://artifacthub.io/packages/helm/bitnami/valkey?modal=install).
- `rm -rf stack/bitnami/* && helm template bitnami/valkey --output-dir stack/bitnami --set auth.rbac.create=false,readinessProbe.enabled=false,livenessProbe.enabled=false,startupProbe.enabled=false,podSecurityContext.enabled=false,containerSecurityContext.enabled=false,primary.persistence.enabled=false,fullnameOverride=valkey --namespace valkey`