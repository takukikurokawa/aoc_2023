#!/bin/sh -eu

nim compile -o=nim$1.out nim$1.nim 2> /dev/null
./nim$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm nim$1.out
