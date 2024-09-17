FROM ubuntu:latest

ENV MACHINE_NAME=vscode-remote

WORKDIR /tmp

RUN export DEBIAN_FRONTEND=noninteractive;\ 
    apt-get update; \
    apt-get install -y --no-install-recommends \
    tzdata ca-certificates git build-essential curl ca-certificates gnome-keyring; \
    curl -sL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" --output /tmp/vscode-cli.tar.gz; \
    tar -xf /tmp/vscode-cli.tar.gz -C /usr/bin; \
    rm /tmp/vscode-cli.tar.gz;

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y --no-install-recommends \
    nodejs npm python3 python3-pip python3-venv; \
    npm install -g --loglevel=info n; \
    n stable; \
    npm install -g --loglevel=info nodemon n ts-node typescript; 

COPY src/entrypoint src/install-vscode-extensions /usr/local/bin/

USER root

VOLUME [ "/root" ]

ENTRYPOINT [ "entrypoint"]