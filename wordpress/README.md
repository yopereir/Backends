# Wordpress
This project contains wordpress stack deployment.

## Conventions:
- `stack` folder contains all the deployment files organized by purpose of stack.
- `deploy.sh` script is used to deploy the vanilla stack to a local kubernetes cluster.
- `secrets` folder contains the secrets used by the stack.

## How Tos:
- Deploy local stack:
    * Run first have a local kubernets cluster running.
    * Then run `./deploy.sh`.
    * Port forward to localhost using last commented out command from `deploy.sh` file.