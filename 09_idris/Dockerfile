FROM debian:latest

RUN apt-get update && apt-get install -y \
    chezscheme \
    curl \
    gcc \
    git \
    libgmp-dev \
    make \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV PATH /root/.pack/bin:/root/.idris2/bin:$PATH

RUN echo "" | bash -c "$(curl -fsSL https://raw.githubusercontent.com/stefan-hoeck/idris2-pack/main/install.bash)"

CMD [bash]
