# docker-nginx

This repository provides Dockerfiles for Fedora based images with nginx.

## How to use

To build a react based client side rendered single page application, use the following Dockerfile.

```Dockerfile
FROM ghcr.io/swiss-digital-assets-institute/node:14 as dev

ARG UID=1000
ENV UID=${UID}

RUN useradd -d /app -l -m -Uu ${UID} -r -s /bin/bash node && \
  chown -R node:node /app

USER node
ENV LANG C.UTF-8

WORKDIR /app
COPY --chown=node:node package.json package-lock.json /app/
RUN npm install -q

# Copy application
COPY --chown=node:node . /app/

RUN npm run build

FROM ghcr.io/swiss-digital-assets-institute/nginx:latest as prod

COPY --from=dev --chown=nginx:nginx /app/build/ /usr/share/nginx/html
```
