FROM debian:latest

RUN apt-get update && apt-get install -y \
    curl \
    default-jre \
    g++ \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/x10 \
 && curl -SL "https://sourceforge.net/projects/x10/files/x10/2.6.2/x10-2.6.2_linux_x86_64.tgz/download" \
 |  tar -xz -C /opt/x10

ENV PATH $PATH:/opt/x10/bin

CMD [bash]
