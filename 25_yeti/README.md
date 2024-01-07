Usage:
```
docker build --platform linux/amd64 -t 25_yeti .
docker run --rm -v $(pwd):/app -w /app 25_yeti sh -c "./run.sh 1"
```
