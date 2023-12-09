Usage:
```
docker build --platform linux/amd64 -t 06_fortran .
docker run --rm -v $(pwd):/app -w /app 06_fortran sh -c "./run.sh 1"
```
