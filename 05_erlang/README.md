Usage:
```
docker build --platform linux/amd64 -t 05_erlang .
docker run --rm -v $(pwd):/app -w /app 05_erlang sh -c "./run.sh 1"
```
