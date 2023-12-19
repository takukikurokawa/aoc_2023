FROM debian:latest

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    bison \
    curl \
    flex \
    g++ \
    git \
    libghc-bzlib-dev \
    libmpfr-dev \
    libpcre3-dev \
    libssl-dev \
    libtool \
    make \
    zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/qorelanguage/qore /tmp/qore \
 && cd /tmp/qore \
 && ./reconf.sh \
 && ./configure \
 && make \
 && make install \
 && rm -rf /tmp/*

ENV LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu

CMD [bash]
