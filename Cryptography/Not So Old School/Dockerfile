FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install socat python3 python3-pip

RUN mkdir -p /ctf
WORKDIR /ctf
COPY . .

RUN pip3 install chess

RUN chmod 644 flag.txt

EXPOSE 1337
CMD socat TCP-LISTEN:1337,reuseaddr,fork 'EXEC:python3 /ctf/app.py'