FROM debian:latest

RUN apt-get update && apt-get install -y \
    gcc \
    libncurses5-dev \
    libffi-dev \
    libgl1-mesa-dev \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxrandr-dev \
    libxpm-dev \
    libtinfo5 \
    libgpm-dev \
    curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -SL "http://downloads.sourceforge.net/fbc/FreeBASIC-1.10.0-linux-x86_64.tar.gz?download" \
 |  tar -xz -C /tmp \
 && cd /tmp/FreeBASIC-1.10.0-linux-x86_64 \
 && ./install.sh -i \
 && rm -rf /tmp/*

CMD ["bash"]
