# Apache Airflow
A server for managing crons and data/event driven pipelines.

## Deployment
* This deployment makes use of the official Helm chart.
* Run `./deploy.sh` to deploy stack on connectect kubernetes cluster.
* To re-generate kubernetes object files run the commented out code in `deploy.sh`.

## Conventions
* `scripts` folder contains general scripts to interact with Airflow.
* DAGs are stored in `./scripts/DAGs` folder.