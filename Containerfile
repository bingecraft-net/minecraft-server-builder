FROM ubuntu:noble

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl openjdk-21-jdk zsh

WORKDIR /opt

RUN curl -SLO https://api.papermc.io/v2/projects/velocity/versions/3.4.0-SNAPSHOT/builds/496/downloads/velocity-3.4.0-SNAPSHOT-496.jar

RUN useradd -m minecraft

USER minecraft

WORKDIR /home/minecraft

COPY --chown=minecraft ./overrides server

WORKDIR server

CMD exec java -jar /opt/velocity-3.4.0-SNAPSHOT-496.jar
