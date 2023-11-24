FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y qemu-system-x86-64 xinetd
RUN groupadd -r ctf && useradd -r -g ctf ctf

COPY challenge/bzImage               /home/ctf/bzImage
COPY challenge/initramfs.cpio.gz     /home/ctf/initramfs.cpio.gz
COPY challenge/run.sh                /home/ctf/run.sh

RUN echo '#!/bin/bash\nservice xinetd restart && /bin/sleep infinity' > /etc/init.sh
RUN echo 'service ctf\n\
{\n\
    disable = no\n\
    socket_type = stream\n\
    protocol = tcp\n\
    wait = no\n\
    user = ctf\n\
    type = UNLISTED\n\
    port = 31337\n\
    bind = 0.0.0.0\n\
    server = /home/ctf/run.sh\n\
}' > /etc/xinetd.d/ctf

RUN chmod 400 /etc/xinetd.d/ctf
RUN chmod 444 /home/ctf/*
RUN chmod 550 /home/ctf/run.sh /etc/init.sh
RUN chmod 1733 /tmp /var/tmp /dev/shm
RUN chown -R root:ctf /home/ctf

RUN service xinetd restart
