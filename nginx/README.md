# Nginx
Nginx server implementation.

## Conventions
- Environment variables that are to be loaded into the container are stored in the `.env` file.
- All configs related to nginx are stored within `config` folder, with main config without env variable substitution at `config/nginx.conf` and config file templates with substitution at `config/templates/*.template`.
- To get latest default nginx.conf file, run `docker run --rm --entrypoint=cat nginx /etc/nginx/nginx.conf > ./config/nginx.conf`.
- All website code that is intended to be publicly visible should be placed within `public` folder. Make sure that all files within that folder have global read permissions.
- `nginx.yaml` is the kubernetes stack definition. Use `deploy.sh` to deploy to an existing kubernetes cluster. Use `deploy.sh -i` to setup ingress port-forwarding locally and access via `nginx.test` on browser.