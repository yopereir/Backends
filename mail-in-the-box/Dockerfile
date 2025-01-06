ARG TAG=v71
FROM ubuntu
RUN apt-get update && apt-get install -y git lsb-release locales
RUN git clone https://github.com/mail-in-a-box/mailinabox
WORKDIR /mailinabox
RUN git checkout $TAG
#RUN setup/start.sh