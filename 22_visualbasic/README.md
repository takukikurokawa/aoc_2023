Usage:
```
docker build --platform linux/amd64 -t 22_visualbasic .
docker run --rm -v $(pwd):/app -w /app 22_visualbasic sh -c "./run.sh 1"
```
