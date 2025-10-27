# Apache Maven
Apache Maven implementation.

## Conventions
- `stacks` folder contain different implementations of the full Apache Maven stack.
- Within the `stacks` folder, `Dockerfile` contains the base Apache Maven image, `.env` contains the secrets used by Apache Maven and all `.yaml` files define the kubernetes stack.
- `src` folder contains the source code for the Java application that will be deployed to the maven container.
- `pom.xml` file contains the build config for the Java application.
- `deploy.sh` script deploys the stack. Use `./deploy.sh -fn` to delete all previous resources for a clean setup. Use `./deploy.sh -i` to setup an ingress tunnel on port 80.
