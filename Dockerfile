# ================================================
# + Build environment
# ================================================
FROM amazoncorretto:17-alpine-jdk AS build
ARG version=1.19.2

RUN apk add --no-cache curl jq

# Install PaperMC
WORKDIR /opt/papermc
COPY ./papermc.sh /opt/papermc/papermc.sh
RUN chmod +x /opt/papermc/papermc.sh && \
    /opt/papermc/papermc.sh ${version}

# ================================================
# + Runtime environment
# ================================================
FROM amazoncorretto:17-alpine-jdk AS runtime
WORKDIR /data

RUN apk add --no-cache rcon su-exec

COPY --from=build /opt/papermc /opt/papermc
VOLUME [ "/data" ]
EXPOSE 25565/tcp
EXPOSE 25565/udp

# Java VM memory options
ARG java_mem=4G
ENV JAVA_MEM=${java_mem}

# Java VM options
ARG java_args="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
ENV JAVA_ARGS=${java_args}

COPY ./entrypoint.sh /opt/papermc/
COPY ./start.sh /opt/papermc/
RUN chmod +x /opt/papermc/entrypoint.sh

ENTRYPOINT [ "/opt/papermc/entrypoint.sh", "/opt/papermc/start.sh" ]