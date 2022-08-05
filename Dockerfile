FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
    && apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release \
        tzdata \
        unzip \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo \
         "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
         $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && curl -L https://tarantool.io/gDdNysu/release/2/installer.sh | bash \
    && apt-get install -y \
        tarantool \
        cartridge-cli \
        docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*
