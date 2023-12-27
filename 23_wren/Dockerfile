FROM debian:latest

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
 && curl -SL "https://github.com/wren-lang/wren-cli/releases/download/0.4.0/wren-cli-linux-0.4.0.zip" -o wren.zip \
 && unzip wren.zip -d . \
 && mv wren-cli-linux-0.4.0/wren_cli /usr/local/bin/wren_cli \
 && rm -rf /tmp/*

CMD [bash]
