Usage:
```
docker build --platform linux/amd64 -t 03_cobol .
docker run --rm -v $(pwd):/app -w /app 03_cobol sh -c "./run.sh 1"
```
