ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.18

FROM docker.io/tiredofit/nginx:${DISTRO}-${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG ELEMENT_VERSION

ENV ELEMENT_VERSION=${ELEMENT_VERSION:-"v1.11.37"} \
    ELEMENT_REPO_URL=https://github.com/vector-im/element-web \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE \
    NGINX_SITE_ENABLED=element \
    IMAGE_NAME="tiredofit/element" \
    IMAGE_REPO_URL="https://github.com/tiredofit/element/"

RUN source assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    mkdir -p "${NGINX_WEBROOT}" && \
    curl -sSL https://github.com/vector-im/element-web/releases/download/${ELEMENT_VERSION}/element-${ELEMENT_VERSION}.tar.gz | tar xvfz - --strip 1 -C ${NGINX_WEBROOT} && \
    chown -R "${NGINX_USER}":"${NGINX_GROUP}" "${NGINX_WEBROOT}" && \
    package cleanup

COPY install /
