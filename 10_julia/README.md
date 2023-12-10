Usage:
```
docker build --platform linux/amd64 -t 10_julia .
docker run --rm -v $(pwd):/app -w /app 10_julia sh -c "./run.sh 1"
```
