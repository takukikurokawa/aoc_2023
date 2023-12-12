Usage:
```
docker build --platform linux/amd64 -t 12_lisp .
docker run --rm -v $(pwd):/app -w /app 12_lisp sh -c "./run.sh 1"
```
