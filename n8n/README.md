# N8n
Open source version of Zapier. Low-code DevOps stack.

## Conventions
- `stacks` folder contain different implementations of the full neo4j stack.
- Within the `stacks` folder, `Dockerfile` contains the base neo4j image, `./secrets/.env.ENVIRONMENT` contains the secrets used by neo4j and all `.yaml` files define the kubernetes stack.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.

## Stacks
### K8s
- Obtained from official source [here](https://github.com/n8n-io/n8n-hosting/tree/main/kubernetes).

### AI kit
- Obtained from official source [here](https://github.com/n8n-io/self-hosted-ai-starter-kit/tree/main).