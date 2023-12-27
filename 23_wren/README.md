Usage:
```
docker build --platform linux/amd64 -t 23_wren .
docker run --rm -v $(pwd):/app -w /app 23_wren sh -c "./run.sh 1"
```
