#!/bin/sh -eu

idris2 idris$1.idr -o idris$1.out
./build/exec/idris$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm -r build
