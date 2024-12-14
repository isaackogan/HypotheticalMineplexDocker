#           BASIC FILE SETUP

FROM        node:22-bullseye-slim AS base

LABEL       author="Fallen" maintainer="info@isaackogan.com"

#           LINUX PACKAGES

RUN         apt update \
            && apt -y install tini \
            && useradd -m -d /home/web-server web-server

FROM        base AS with_packages

#           USER & ENTRYPOINT

USER        web-server
ENV         USER=web-server HOME=/home/web-server ASSET_PATH=/home/web-server/dist/src/assets DIST_PATH=/home/web-server/dist

WORKDIR     /home/web-server

#           NODE PACKAGES

COPY        package.json ./

RUN         npm install

FROM        with_packages AS final

#           PROJECT SOURCE CODE

COPY        ./index.js ./index.js

#           START SERVER

COPY        --chown=web-server:web-server ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
