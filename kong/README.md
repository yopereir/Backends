# Kong
Deployment for Kong API Gateway stack.

## Deployment
* This deployment makes use of the official Helm chart.
* Run `./deploy.sh` to deploy stack on connectect kubernetes cluster.
* To re-generate kubernetes object files run the commented out code in `deploy.sh`.

## Conventions
* There are 3 helm charts being used- kong/ingress, kong/kong, kong-gateway-operator.
* kong/ingress is a wrapper over kong/kong, hence do NOT deploy both charts together.
* Params [ref](https://github.com/Kong/charts/tree/main/charts/kong#configuration) for helm charts.