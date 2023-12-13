Usage:
```
docker build --platform linux/amd64 -t 13_maxima .
docker run --rm -v $(pwd):/app -w /app 13_maxima sh -c "./run.sh 1"
```
