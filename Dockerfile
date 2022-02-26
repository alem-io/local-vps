FROM ubuntu:18.04

RUN apt update
RUN apt install -y curl

# setup sshd
RUN apt install -y openssh-server
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN service ssh start

# setup credentials for root user
RUN echo 'root:password' | chpasswd

# install docker-cli
ARG DOCKER_URL=https://download.docker.com/linux/static/stable/x86_64
ARG DOCKER_VERSION=docker-20.10.9
RUN curl -fsSL $DOCKER_URL/$DOCKER_VERSION.tgz | tar zxvf - --strip 1 -C /usr/bin docker/docker

WORKDIR /tmp/workdir
COPY init.sh .

ENTRYPOINT ["/tmp/workdir/init.sh"]
