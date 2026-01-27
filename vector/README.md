# Vector
Vector is log mapping config language used to transform logs from one source to another.

## Conventions
- `stacks` folder contain different implementations of the full Vector stack.
- Within the `stacks` folder, `./secrets/.env.ENVIRONMENT` contains the secrets used by httpd and all `.yaml` files define the kubernetes stack.
- `deploy.bat` script deploys the stack. By default it deploys the vector distroless container, with custom config and secret envs loaded into container.
