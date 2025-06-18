FROM ubuntu:noble

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl openjdk-21-jdk unzip zsh

RUN curl -sLO https://github.com/itzg/rcon-cli/releases/download/1.6.9/rcon-cli_1.6.9_linux_amd64.tar.gz && \
    tar xf rcon-cli_1.6.9_linux_amd64.tar.gz rcon-cli && \
    mv rcon-cli /bin/rcon-cli && \
    rm rcon-cli_1.6.9_linux_amd64.tar.gz

WORKDIR /opt

ARG MINECRAFT_VERSION

ARG FORGE_VERSION

RUN curl -sLO https://maven.minecraftforge.net/net/minecraftforge/forge/$MINECRAFT_VERSION-$FORGE_VERSION/forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar

RUN java -jar /opt/forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar --installServer server

RUN rm forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar*

RUN sed -i 's/^java/exec java/' server/run.sh

ARG MONI_VERSION

RUN curl \
  --fail \
  --location \
  --remote-name \
  https://github.com/ThePansmith/Monifactory/releases/download/$MONI_VERSION/Monifactory-Beta.$MONI_VERSION-server.zip

RUN unzip -d pack /opt/Monifactory-Beta.$MONI_VERSION-server.zip

RUN rm Monifactory-Beta.$MONI_VERSION-server.zip

RUN useradd -m minecraft

USER minecraft

WORKDIR /home/minecraft

COPY ./bin/ .local/bin/

ENV PATH="$PATH:/home/minecraft/.local/bin"

RUN cp -r /opt/server server

RUN cp -r /opt/pack/overrides/* server

COPY --chown=minecraft ./overrides/* server

WORKDIR server

CMD exec start ./run.sh
