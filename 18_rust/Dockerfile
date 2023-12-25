FROM debian:latest

RUN apt-get update && apt-get install -y \
    curl \
    gcc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN cd /tmp \
 && curl -SLO "https://static.rust-lang.org/rustup/archive/1.26.0/x86_64-unknown-linux-gnu/rustup-init" \
 && chmod +x rustup-init \
 && ./rustup-init -y --no-modify-path --profile minimal --default-toolchain 1.74.1 --default-host x86_64-unknown-linux-gnu \
 && rm rustup-init

CMD [bash]
