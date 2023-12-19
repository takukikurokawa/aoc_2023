Usage:
```
docker build --platform linux/amd64 -t 17_qore .
docker run --rm -v $(pwd):/app -w /app 17_qore sh -c "./run.sh 1"
```
