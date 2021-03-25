FROM ghcr.io/hotio/base@sha256:231ec84a2cd1f6b38387df38fe6f61c5b5d8c19b5f433c658bb985966703450c

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
