Usage:
```
docker build --platform linux/amd64 -t 24_x10 .
docker run --rm -v $(pwd):/app -w /app 24_x10 sh -c "./run.sh 1"
```
