Usage:
```
docker build --platform linux/amd64 -t 04_d .
docker run --rm -v $(pwd):/app -w /app 04_d sh -c "./run.sh 1"
```
