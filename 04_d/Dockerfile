FROM debian:latest

RUN apt-get update && apt-get install -y \
    gdc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
