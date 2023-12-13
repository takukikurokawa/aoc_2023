FROM debian:latest

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    git \
    make \
    sbcl \
    texinfo \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://git.code.sf.net/p/maxima/code /opt/maxima-code \
 && cd /opt/maxima-code \
 && ./bootstrap \
 && ./configure --enable-sbcl \
 && make install

CMD [bash]
