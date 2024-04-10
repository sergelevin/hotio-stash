ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 9999
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="9999/tcp,9999/udp"

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs \
        py3-beautifulsoup4 py3-lxml && \
    apk add --no-cache --virtual=build-dependencies py3-pip && \
    pip3 install --break-system-packages --no-cache-dir --upgrade \
        stashapp-tools cloudscraper && \
    apk del --purge build-dependencies

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
