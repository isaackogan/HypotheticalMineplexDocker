FROM        openjdk:8-jdk-slim-bullseye AS base

LABEL       author="Fallen" maintainer="info@isaackogan.com"

USER        root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       fontconfig \
       fonts-dejavu-core \
       fonts-dejavu \
       mariadb-client \
       redis-tools \
       python3 \
       libfreetype6 \
       libxrender1 \
       unzip \
       libxext6 \
    && useradd -m -d /home/mineplex mineplex

FROM        base AS with_packages

USER        mineplex
ENV         USER=mineplex HOME=/home/mineplex
WORKDIR     /home/mineplex

COPY        --chown=mineplex:mineplex ./server ./server
COPY        --chown=mineplex:mineplex ./update ./update

# Default ENV's
ENV         MINIMUM_MEMORY=1G MAXIMUM_MEMORY=4G
ENV         JAVA_OPTS="-Djava.awt.headless=true -Dsun.java2d.debugfonts=true -Dsun.awt.fontconfig=/etc/fonts/fonts.conf"


# Start Server
COPY        --chown=mineplex:mineplex ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh < /dev/stdin"]
