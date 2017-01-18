FROM lochnair/base:alpine-java
MAINTAINER Lochnair <me@lochnair.net>
LABEL Description="Docker image for Unifi (Alpine)"

EXPOSE 8080 8081 8443 8843 8880

## Environment variables
ENV UNIFI_VERSION 5.4.9

# Download Unifi
ADD https://dl.ubnt.com/unifi/${UNIFI_VERSION}/UniFi.unix.zip /tmp/
RUN unzip /tmp/UniFi.unix.zip -d /app
RUN rm /tmp/UniFi.unix.zip

# Add symlink to MongoDB
RUN ln -s /usr/bin/mongod /app/UniFi/bin/mongod

## Install dependencies from the testing repository
RUN apk add \
    --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --update \
    mongodb

# Change user home to UniFi installation
RUN usermod -d /app/UniFi cont

VOLUME /config