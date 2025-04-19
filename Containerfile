FROM ubuntu:noble

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl openjdk-21-jdk zsh

WORKDIR /opt

ARG VELOCITY_VERSION

ARG VELOCITY_BUILD

RUN curl -sfLo velocity.jar https://api.papermc.io/v2/projects/velocity/versions/$VELOCITY_VERSION/builds/$VELOCITY_BUILD/downloads/velocity-$VELOCITY_VERSION-$VELOCITY_BUILD.jar

RUN useradd -m minecraft

USER minecraft

WORKDIR /home/minecraft

COPY --chown=minecraft ./overrides server

WORKDIR server

CMD exec java -jar /opt/velocity.jar
