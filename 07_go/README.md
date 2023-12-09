Usage:
```
docker build --platform linux/amd64 -t 07_go .
docker run --rm -v $(pwd):/app -w /app 07_go sh -c "./run.sh 1"
```
