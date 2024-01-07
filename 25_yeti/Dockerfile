FROM debian:latest

RUN apt-get update && apt-get install -y \
    default-jre \
    wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget "http://dot.planet.ee/yeti/yeti.jar" -P /opt

CMD [bash]
