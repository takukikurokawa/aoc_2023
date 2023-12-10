Usage:
```
docker build --platform linux/amd64 -t 09_idris .
docker run --rm -v $(pwd):/app -w /app 09_idris sh -c "./run.sh 1"
```
