FROM debian:latest

RUN apt-get update && apt-get install -y \
    ca-certificates \
    dirmngr \
    gnupg \
 && gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/debian stable-buster main" > /etc/apt/sources.list.d/mono-official-stable.list \
 && apt-get update && apt-get install -y \
    mono-vbnc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD [bash]
