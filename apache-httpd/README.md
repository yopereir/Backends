# Apache-httpd
Apache-httpd is a webserver.

## Conventions
- `stacks` folder contain different implementations of the full apache-httpd stack.
- Within the `stacks` folder, `./secrets/.env.ENVIRONMENT` contains the secrets used by httpd and all `.yaml` files define the kubernetes stack.
- `deploy.bat` script deploys the stack. By default it deploys the apache container, with custom config and secret envs loaded into container ONLY.

