Usage:
```
docker build --platform linux/amd64 -t 02_basic .
docker run --rm -v $(pwd):/app -w /app 02_basic sh -c "./run.sh 1"
```
