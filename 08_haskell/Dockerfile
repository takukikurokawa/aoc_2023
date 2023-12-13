FROM debian:latest

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libffi-dev \
    libffi8 \
    libgmp-dev \
    libgmp10 \
    libncurses-dev \
    libncurses5 \
    libtinfo5 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

ENV PATH /root/.ghcup/bin:$PATH

RUN cabal install --lib \
    containers \
    split

CMD [bash]
