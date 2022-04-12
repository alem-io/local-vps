FROM ubuntu:18.04

RUN apt update
RUN apt install -y curl git openssh-server sudo

# setup credentials for root user
RUN echo 'root:password' | chpasswd

COPY systemctl.py /usr/bin/systemctl
COPY journalctl.py /usr/bin/journalctl
RUN chmod 755 /usr/bin/systemctl /usr/bin/journalctl

# setup sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN systemctl start ssh

WORKDIR /tmp/workdir
COPY init.sh .

ENTRYPOINT ["/tmp/workdir/init.sh"]
