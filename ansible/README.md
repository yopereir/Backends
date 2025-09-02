# Ansible
Framework for distributed workload management and creating CI/CD pipelines.

## Conventions
- `stacks` folder contain different implementations of the full clearml stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.