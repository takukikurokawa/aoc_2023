Usage:
```
docker build --platform linux/amd64 -t 21_unicon .
docker run --rm -v $(pwd):/app -w /app 21_unicon sh -c "./run.sh 1"
```
