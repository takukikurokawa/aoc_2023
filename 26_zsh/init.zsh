#!/bin/zsh

set -e

if [ "$#" -eq 0 ]; then
    echo "Usage: zsh init.zsh 01_ada"
    exit 1
fi

mkdir ../$1
cd ../$1

echo "FROM debian:latest

RUN apt-get update && apt-get install -y \\
    curl \\
 && apt-get clean \\
 && rm -rf /var/lib/apt/lists/*

RUN curl -SL \"\" \\
 |  tar -xz -C /tmp \\
 && install \\
 && rm -rf /tmp/*

CMD ["bash"]" > Dockerfile

echo "Usage:
\`\`\`
docker build --platform linux/amd64 -t $1 .
docker run --rm -v \$(pwd):/app -w /app $1 sh -c \"./run.sh 1\"
\`\`\`" > README.md

echo "#!/bin/sh -eu

./${1:3}\$1.out < data/in.txt > data/out\$1.txt

cat data/out\$1.txt

rm ${1:3}\$1.out" > run.sh

chmod +x run.sh

mkdir data
