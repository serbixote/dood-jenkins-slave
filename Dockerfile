ARG SLAVE_VERSION

FROM alpine AS downloader

ARG DOCKER_CLIENT_VERSION
RUN apk add --no-cache curl \
    && curl -sSL -o docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLIENT_VERSION}-ce.tgz \
    && tar xzvf docker.tgz

FROM jenkinsci/jnlp-slave:${SLAVE_VERSION}-alpine

USER root

RUN apk add --no-cache sudo

USER jenkins

COPY --from=downloader /docker/docker /bin/docker_bin
COPY docker /bin/docker
COPY sudoers /etc/sudoers
