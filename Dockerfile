ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.20

FROM docker.io/tiredofit/unit:${DISTRO}-${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG ELEMENT_VERSION

ENV ELEMENT_VERSION=${ELEMENT_VERSION:-"v1.11.100"} \
    ELEMENT_REPO_URL=https://github.com/vector-im/element-web \
    UNIT_ENABLE_CREATE_SAMPLE_HTML=FALSE \
    UNIT_SITE_ENABLED=element \
    IMAGE_NAME="tiredofit/element" \
    IMAGE_REPO_URL="https://github.com/tiredofit/element/"

RUN source assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    mkdir -p "${UNIT_WEBROOT}" && \
    curl -sSL https://github.com/vector-im/element-web/releases/download/${ELEMENT_VERSION}/element-${ELEMENT_VERSION}.tar.gz | tar xvfz - --strip 1 -C ${UNIT_WEBROOT} && \
    chown -R "${UNIT_USER}":"${UNIT_GROUP}" "${UNIT_WEBROOT}" && \
    package cleanup

COPY install /
