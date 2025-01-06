# Mail in the box
SMTP server solution.

## Deploy
### Locally
1. Start a Ubuntu machine.
2. Run `apt-get update && apt-get install -y git lsb-release locales`
3. Run `git clone https://github.com/mail-in-a-box/mailinabox && cd mailinabox && git checkout $TAG` where TAG can be 71.
4. RUN `setup/start.sh`.

### TODO:Kubernetes
1. With an existing Kubernetes Cluster running, run `./deploy.sh`.
2. This will build the MITB docker image and deploy it to the namespace.

## Conventions
* Get the RELEASE TAG to build the image from (here)[https://github.com/mail-in-a-box/mailinabox/releases].
* All scripts that are to be called via a cronjob are stored within the `scripts` folder.
* All error logs from all cronjobs are stored at `/var/log/errors`.