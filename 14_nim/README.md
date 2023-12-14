Usage:
```
docker build --platform linux/amd64 -t 14_nim .
docker run --rm -v $(pwd):/app -w /app 14_nim sh -c "./run.sh 1"
```
