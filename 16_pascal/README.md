Usage:
```
docker build --platform linux/amd64 -t 16_pascal .
docker run --rm -v $(pwd):/app -w /app 16_pascal sh -c "./run.sh 1"
```
