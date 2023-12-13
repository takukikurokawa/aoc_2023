Usage:
```
docker build --platform linux/amd64 -t 08_haskell .
docker run --rm -v $(pwd):/app -w /app 08_haskell sh -c "./run.sh 1"
```
