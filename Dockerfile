FROM lochnair/base:alpine-jre8
MAINTAINER Lochnair <me@lochnair.net>
LABEL Description="Docker image for Unifi (Alpine)"

EXPOSE 8080 8081 8443 8843 8880

## Environment variables
ENV UNIFI_VERSION 5.4.14

# Download Unifi
RUN curl -f -L -o /tmp/UniFi.unix.zip https://dl.ubnt.com/unifi/${UNIFI_VERSION}/UniFi.unix.zip

RUN \
# Extract UniFi archive
unzip /tmp/UniFi.unix.zip -d /app && \
rm /tmp/UniFi.unix.zip

RUN \
## Install dependencies from the testing repository
apk add \
--no-cache \
--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
--update \
mongodb

RUN \
# Fix symlink
ln -sf /usr/bin/mongod /app/UniFi/bin/mongod && \

# Remove unneeded MongoDB executables (saves ~82M)
# UniFi only requires the mongo daemon.
rm /usr/bin/mongo && \
rm /usr/bin/mongoperf && \
rm /usr/bin/mongos && \
rm /usr/bin/mongosniff && \

# Remove unnecessary native libraries
rm -rf /app/UniFi/lib/native/{Mac,Windows} && \
rm -rf /app/UniFi/lib/native/Linux/armhf

VOLUME /config

COPY root/ /
