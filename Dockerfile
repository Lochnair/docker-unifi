FROM lochnair/base:alpine-java
MAINTAINER Lochnair <me@lochnair.net>
LABEL Description="Docker image for Unifi (Alpine)"

EXPOSE 8080 8081 8443 8843 8880

## Environment variables
ENV UNIFI_VERSION 5.4.9

# Download Unifi
RUN curl -L -o /tmp/UniFi.unix.zip https://dl.ubnt.com/unifi/${UNIFI_VERSION}/UniFi.unix.zip
RUN \
unzip /tmp/UniFi.unix.zip -d /app && \
rm /tmp/UniFi.unix.zip && \

## Install dependencies from the testing repository
apk add \
--no-cache \
--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
--update \
mongodb && \

VOLUME /config

COPY root/ /
