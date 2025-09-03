FROM fedora
COPY ./src /ansible-project
WORKDIR /ansible-project
RUN dnf update -y
RUN dnf install -y gcc gcc-c++ make python3-devel libffi-devel oniguruma oniguruma-devel podman python3 python3-pip
RUN python3 -m pip install --upgrade pip setuptools wheel ansible argcomplete ansible-navigator ansible-builder ansible-navigator
RUN activate-global-python-argcomplete && ansible-navigator --version
#RUN ansible-navigator --version
#RUN ansible-builder --version