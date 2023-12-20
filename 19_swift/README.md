Usage:
```
docker build --platform linux/amd64 -t 19_swift .
docker run --rm -v $(pwd):/app -w /app 19_swift sh -c "./run.sh 1"
```
