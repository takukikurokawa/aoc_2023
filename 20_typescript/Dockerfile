FROM debian:latest

RUN apt-get update && apt-get install -y \
    npm \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g \
    typescript \
    ts-node \
    tslib \
    @types/node

CMD [bash]
