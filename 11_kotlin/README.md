Usage:
```
docker build --platform linux/amd64 -t 11_kotlin .
docker run --rm -v $(pwd):/app -w /app 11_kotlin sh -c "./run.sh 1"
```
