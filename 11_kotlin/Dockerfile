FROM debian:latest

RUN apt-get update && apt-get install -y \
    curl \
    default-jre \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -SL "https://github.com/JetBrains/kotlin/releases/download/v1.9.21/kotlin-native-linux-x86_64-1.9.21.tar.gz" \
 |  tar -xz -C /opt

ENV PATH /opt/kotlin-native-linux-x86_64-1.9.21/bin:$PATH

RUN echo "fun main() {}" > kotlin.kt \
 && kotlinc-native kotlin.kt \
 && rm kotlin.kt program.kexe

CMD [bash]
