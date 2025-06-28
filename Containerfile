FROM ubuntu:noble

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl openjdk-21-jdk zsh

WORKDIR /opt

ARG VELOCITY_VERSION

ARG VELOCITY_BUILD

RUN curl -sfLo velocity.jar https://api.papermc.io/v2/projects/velocity/versions/$VELOCITY_VERSION/builds/$VELOCITY_BUILD/downloads/velocity-$VELOCITY_VERSION-$VELOCITY_BUILD.jar

RUN curl -sfLo ambassador.jar https://cdn.modrinth.com/data/cOj6YqJM/versions/YeQbhgna/Ambassador-Velocity-1.4.5-all.jar

RUN useradd -m minecraft

USER minecraft

WORKDIR /home/minecraft

COPY --chown=minecraft ./overrides server

WORKDIR server

RUN mkdir plugins

RUN ln -s /opt/ambassador.jar plugins/

CMD exec java -jar /opt/velocity.jar
