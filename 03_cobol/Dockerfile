FROM debian:latest

RUN apt-get update && apt-get install -y \
    gnucobol \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
