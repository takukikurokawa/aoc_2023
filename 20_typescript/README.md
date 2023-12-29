Usage:
```
docker build --platform linux/amd64 -t 20_typescript .
docker run --rm -v $(pwd):/app -w /app 20_typescript sh -c "./run.sh 1"
```
