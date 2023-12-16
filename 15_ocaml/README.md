Usage:
```
docker build --platform linux/amd64 -t 15_ocaml .
docker run --rm -v $(pwd):/app -w /app 15_ocaml sh -c "./run.sh 1"
```
