# ClearML
Framework for training AI models.

# How Tos
* Connect to deployed clearml server
    - Install clearml library for python `python -m pip install clearml`.
    - Make sure clearml-apiserver and clearml-webserver are running at localhost:8008 and localhost:8080 respectively.
    - Go here(http://localhost:8080/settings/workspace-configuration) to get credentials then type `clearml-init` in terminal.
    - Then run `python ./scripts/tests/createTask.py`.

## Conventions
- `stacks` folder contain different implementations of the full clearml stack.
- Within the `stacks` folder, `Dockerfile` contains the base clearml image, `./secrets/.env.ENVIRONMENT` contains the secrets used by clearml and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.