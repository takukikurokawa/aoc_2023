Usage:
```
docker build --platform linux/amd64 -t 01_ada .
docker run --rm -v $(pwd):/app -w /app 01_ada sh -c "./run.sh 1"
```
