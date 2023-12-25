FROM debian:latest

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libalut-dev \
    libfreetype6-dev \
    libgl1-mesa-glx \
    libglu1-mesa-dev \
    libjpeg-dev \
    libogg-dev \
    libopenal-dev \
    libpng-dev \
    libssl-dev \
    libvorbis-dev \
    libx11-dev \
    libxft-dev \
    unixodbc-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
 && git clone https://github.com/uniconproject/unicon.git \
 && cd unicon \
 && ./configure --disable-graphics \
 && make \
 && make install \
 && rm -rf /tmp/*

CMD [bash]
