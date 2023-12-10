FROM debian:latest

RUN apt-get update && apt-get install -y \
    curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -SL "https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.4-linux-x86_64.tar.gz" \
 |  tar -xz -C /opt \
 && ln -s /opt/julia-1.9.4/bin/julia /usr/local/bin/julia

CMD ["bash"]
