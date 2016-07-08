FROM java:8-jre-alpine
MAINTAINER Lochnair <me@lochnair.net>
LABEL Description="Docker image for Unifi based on the offical Java image (Alpine)"

## Environment variables
ENV UNIFI_VERSION 5.0.7

## Install packages from testing repository
RUN apk add \
    --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --update \
    ca-certificates \
    mongodb \
    libssl1.0 \
    unzip

# Download Unifi
RUN mkdir /app
WORKDIR /app
RUN wget https://dl.ubnt.com/unifi/${UNIFI_VERSION}/UniFi.unix.zip; \
    unzip UniFi.unix.zip; \
    rm -v uniFi.unix.zip

# Uninstall unzip
RUN apk remove \
    --no-cache \
    unzip
