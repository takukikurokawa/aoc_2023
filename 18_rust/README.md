Usage:
```
docker build --platform linux/amd64 -t 18_rust .
docker run --rm -v $(pwd):/app -w /app 18_rust sh -c "./run.sh 1"
```
